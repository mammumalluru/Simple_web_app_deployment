variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
} 

variable "key_name" {
  
 description = "Existing AWS Key Pair name"
  type        = string
  default     = "my_keypair"
}