yay -S --sudoloop vulkan-amdgpu-pro
yay -S --sudoloop lib32-vulkan-amdgpu-pro
yay -S --sudoloop amf-amdgpu-pro
sudo su -c "echo 'AMD_VULKAN_ICD=RADV' >> /etc/environment"
sudo su -c "echo 'VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.i686.json:/usr/share/vulkan/icd.d/radeon_icd.x86_64.json' >> /etc/environment"
sudo su -c "echo 'AMD_VULKAN_ICD=RADV' >> /etc/profile"
sudo su -c "echo 'VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.i686.json:/usr/share/vulkan/icd.d/radeon_icd.x86_64.json' >> /etc/profile"
sudo su -c "echo 'AMD_VULKAN_ICD=RADV' >> /home/icyjiub/.profile"
sudo su -c "echo 'VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.i686.json:/usr/share/vulkan/icd.d/radeon_icd.x86_64.json' >> /home/icyjiub/.profile"
sudo su -c "echo 'AMD_VULKAN_ICD=RADV' >> /home/icyjiub/.zshrc"
sudo su -c "echo 'VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.i686.json:/usr/share/vulkan/icd.d/radeon_icd.x86_64.json' >> /home/icyjiub/.zshrc"
