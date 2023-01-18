
variable "region" {
  type= string
  default= "us-east-1"
}
variable "scheduler" {
  type = bool
  default = true 
}
variable "input_start" {
  type = string
  default = "{\"type\": \"all\",\"command\": \"start\",\"resources\": [\"ASG\",\"EC2\",\"ECS\",\"RDSAurora\",\"RDSInstance\", \"DocDB\", \"EKS\", \"RedShift\"]}"
  
}
variable "input_stop" {
  type = string
  default = "{\"type\": \"all\",\"command\": \"stop\",\"resources\": [\"ASG\",\"EC2\",\"ECS\",\"RDSAurora\",\"RDSInstance\", \"DocDB\", \"EKS\", \"RedShift\"]}"
  
}