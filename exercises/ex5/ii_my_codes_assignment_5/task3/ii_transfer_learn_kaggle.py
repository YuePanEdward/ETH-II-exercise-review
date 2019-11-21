import h5py
import numpy as np
from keras.models import *
from keras.layers import *
from sklearn.utils import shuffle
from IPython.display import SVG
from keras.utils.vis_utils import model_to_dot
import pandas as pd
from keras.preprocessing.image import *
from keras.utils import plot_model

# Based on python 3.7 and keras 2.2.4

# Merge feature vector calculated by different pre-trained models
# random seed
np.random.seed(2019)

X_train = []
X_test = []

for filename in ["gap_resnet50.h5", "gap_xception.h5", "gap_inceptionv3.h5","gap_vgg19.h5"]:
    with h5py.File(filename, 'r') as h:
        print(h)
        X_train.append(np.array(h['train']))
        X_test.append(np.array(h['test']))
        y_train = np.array(h['label'])


X_train = np.concatenate(X_train, axis=1)
X_test = np.concatenate(X_test, axis=1)

print(X_train.shape)
#print(np.array(y_train).shape)

X_train, y_train = shuffle(X_train, y_train)


# Construct model for training

input_tensor = Input(X_train.shape[1:])
x = input_tensor

# Dropout
x = Dropout(0.5)(x)

# FC -> sigmoid
x = Dense(1, activation='sigmoid')(x)

model = Model(input_tensor, x)

model.compile(optimizer='adadelta',
              loss='binary_crossentropy',
              metrics=['accuracy'])

# Train the model

model.fit(X_train, y_train, batch_size=256, epochs=8, verbose=1, validation_split=0.1)

# Save the final model
model.save('my_model.h5')

# Prediction
y_pred = model.predict(X_test, verbose=1)
#y_pred = y_pred.clip(min=0.005, max=0.995)
y_pred = y_pred.clip(min=0, max=1)

image_label=np.ones((25000,1))*-1

image_size = (224, 224)
gen = ImageDataGenerator()
test_generator = gen.flow_from_directory("test2", image_size, shuffle=False,
                                         batch_size=16, class_mode=None)


# write the prediction result to csv using pandas

for i, fname in enumerate(test_generator.filenames):
    index = int(fname[fname.rfind('/')+1:fname.rfind('.')])
    image_label[index]=y_pred[i]

test_label=np.c_[[],[]]

for i in range(image_label.shape[0]):
    if image_label[i]>=0:
        if image_label[i]<0.5:
            image_label[i]=0
        else:
            image_label[i]=1

        test_label=np.r_[test_label,np.c_[i,image_label[i]]]

test_label=test_label.astype(int)
print(test_label)
print(test_label.shape)

df = pd.DataFrame(test_label,columns=['id','label'])
df.set_index(["id"],inplace=True)
df.to_csv('prediction.csv')

# show model
plot_model(model, to_file='model.png')
