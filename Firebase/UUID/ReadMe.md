## Why Firebase?


Firebase is a service that allows us to create real-time apps without having a native back-end(server). Storing and retrieving of data in real-time is done directly from the browser(front-end), i.e. no back-end services is required to fetch the data.

Whenever we save data in Firebase, it generates a unique identification ID for each object. Sometimes it’s hard to maintain or traverse the data on the basis of these randomly generated IDs, because the only way to access data in Firebase is via URL reference (refObject/books//title) for the particular node. So sometimes we need to store data object with our own custom keys.

---> Ref: http://www.tothenew.com/blog/custom-ids-in-firebase/

STATUS: Still EXP.


## What is UUID (Universal Unique Identifier)?

A UUID (Universal Unique Identifier) is a 128-bit number used to uniquely identify some object or entity on the Internet. Depending on the specific mechanisms used, a UUID is either guaranteed to be different or is, at least, extremely likely to be different from any other UUID generated until 3400 A.D

