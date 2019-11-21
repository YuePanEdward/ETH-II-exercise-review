from keras.models import *
from keras.layers import *
from keras.applications import *
from keras.preprocessing.image import *

import h5py

# Based on python 3.7 and keras 2.2.4

def extract_features_using_pretrain_net(MODEL, model_name, image_size, lambda_func=None):

    train_img_number=18719
    test_img_number=6248

    pretrain_batch_size=16

    width = image_size[0]
    height = image_size[1]
    input_tensor = Input((height, width, 3))
    x = input_tensor
    if lambda_func:
        x = Lambda(lambda_func)(x)
    base_model = MODEL(input_tensor=x, weights='imagenet', include_top=False, pooling='avg')
    model = Model(inputs=base_model.input,outputs=base_model.output)
    model.summary()

    gen = ImageDataGenerator()
    train_generator = gen.flow_from_directory("train2", image_size, shuffle=False,
                                              batch_size=pretrain_batch_size)
    test_generator = gen.flow_from_directory("test2", image_size, shuffle=False,
                                             batch_size=pretrain_batch_size, class_mode=None)

    train = model.predict_generator(train_generator,(train_img_number-0.1)//pretrain_batch_size+1)
    test = model.predict_generator(test_generator,(test_img_number-0.1)//pretrain_batch_size+1)

    with h5py.File("gap_%s.h5"%model_name) as h:
        h.create_dataset("train", data=train)
        h.create_dataset("test", data=test)
        h.create_dataset("label", data=train_generator.classes)

# extract feature of training and testing images for several pretrained models

#extract_features_pretrain(VGG16, 'vgg16', (224, 224)) # k*512

print('Begin extracting feature using vgg19')
extract_features_using_pretrain_net(VGG19, 'vgg19', (224, 224)) # k*512
print('Finish extracting feature using vgg19')

print('Begin extracting feature using resnet50')
extract_features_using_pretrain_net(ResNet50,'resnet50',(224, 224)) # k*2048
print('Finish extracting feature using resnet50')

print('Begin extracting feature using xception')
extract_features_using_pretrain_net(Xception, 'xception', (299, 299), xception.preprocess_input) # k*2048
print('Finish extracting feature using xception')

print('Begin extracting feature using inceptionv3')
extract_features_using_pretrain_net(InceptionV3, 'inceptionv3', (299, 299), inception_v3.preprocess_input) # k*2048
print('Finish extracting feature using inceptionv3')
