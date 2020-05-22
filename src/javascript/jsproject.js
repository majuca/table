.pragma library

var jsonData = null;
var project = null;
var listView = null;
var flickable = null;
var flickableImage = []

function getInitialData() {
    if(!jsonData) {
        var data = {
                "name":"",
                "type":"",
                "version":[
                    {
                        "name":qsTr("New version"),
                        "images":[]
                    }
                ]
            }
        return data;
    } else {
        return jsonData;
    }
}

function setName(name) {
    if(jsonData !== null) {
        jsonData.name = name;
        if(project) {
            project.isModified = true;
            project.projectName = name;
        }
    }
}

function getName() {
    if(jsonData !== null) {
        if("name" in jsonData) {
            return jsonData.name;
        }
    }
    return false;
}

function setType(type) {
    if(jsonData !== null) {
        jsonData.type = type;
    }
}

function setImages(images) {
    if(jsonData !== null) {
        jsonData.version[project.currentProjectVersion].images = images;
    }
}

function getImages() {
    if(jsonData !== null) {
        var sources = []
        for(var i=0; i<jsonData.version[project.currentProjectVersion].images.length; i++) {
            if(jsonData.version[project.currentProjectVersion].images[i].parentImage === "stockImage") {
                sources.push(jsonData.version[project.currentProjectVersion].images[i].source);
            }

        }

        return sources;
    }

    return [];
}

function creatImage() {
    if(jsonData !== null) {

        flickable.reset();

        for(var i=0; i<jsonData.version[project.currentProjectVersion].images.length; i++) {
            if(jsonData.version[project.currentProjectVersion].images[i].parentImage === "table") {
                flickable.add(jsonData.version[project.currentProjectVersion].images[i])                
            }

        }

    }

}


function getType() {
    if(jsonData !== null) {
        if("type" in jsonData) {
            return jsonData.type;
        }
    }
    return false;
}

function setVersionName(name, index) {
    if(jsonData !== null) {
        if("version" in jsonData) {
            if(jsonData.version.length>index) {
                if("name" in jsonData.version[index]) {
                    jsonData.version[index].name = name;
                    project.isModified = true;
                }
            }
        }
    }
}

function addVersion(name) {
    if(jsonData !== null) {
        if("version" in jsonData) {
            var newVersion = {
                    "name": name,
                    "images":[]
                }

            jsonData.version.push(newVersion);
            project.isModified = true;
        }
    }
}

function subVersion(index) {
    if(jsonData !== null) {
        if("version" in jsonData) {
            if(jsonData.version.length === 1)  {
                return;
            }

            jsonData.version.splice(index,1);
            project.isModified = true;
        }
    }

}

function getVersionList() {
    if(jsonData !== null) {
        var version = [];
        if("version" in jsonData) {
            for(var i=0;i<jsonData.version.length; i++) {
                if("name" in jsonData.version[i]) {
                    version.push(jsonData.version[i].name);
                }
            }
        }

        return version;

    } else {
        return []
    }
}

function open(url) {
    var request = new XMLHttpRequest();
    request.open("GET", url, false);
    request.send(null);

    jsonData =JSON.parse(request.responseText);
    if(jsonData !== false) {
       load();
       return true;
    }

    return false;
}

function load() {
    project.loaded();
    listView.model = getImages();
    creatImage();
}


function save() {
    var request = new XMLHttpRequest();
    jsonData = getInitialData();
    setName(project.projectName);
    setType(project.projectType);

    if(listView) {
        var jsonImages = [];
        for(var i=0; i<listView.count;i++) {
            var image = listView.itemAtIndex(i);
            if(image) {
                var json = {
                    "source":image.source,
                    "parentImage":"stockImage"
                }
                jsonImages.push(json);
            }
        }

        for(i=0; i<flickableImage.length;i++) {
            image = flickableImage[i].obj;
            if(image) {
                json = {
                    "source":image.source,
                    "x":image.x,
                    "y":image.y,
                    "height":image.height,
                    "parentImage":"table",
                    "frameType":image.frameType,
                    "format":image.format,
                    "size":image.size,
                    "horizontal":image.horizontal,
                    "vertical":image.vertical
                }
                jsonImages.push(json);
            }
        }

        setImages(jsonImages);
    }

    request.open("PUT", project.projectFile, false);
    request.send(JSON.stringify(jsonData));

    return request.status;
}

function setListView(list) {
    listView = list;
}
