Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267016AbSL3RiS>; Mon, 30 Dec 2002 12:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267015AbSL3RiS>; Mon, 30 Dec 2002 12:38:18 -0500
Received: from ce.fis.unam.mx ([132.248.33.1]:16559 "EHLO ce.fis.unam.mx")
	by vger.kernel.org with ESMTP id <S267019AbSL3RhO>;
	Mon, 30 Dec 2002 12:37:14 -0500
Subject: lots of unresolved symbols on 2.5.53
From: Max Valdez <maxvaldez@yahoo.com>
To: kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-GgnW0JICjLKqXlKh/n3x"
X-Mailer: Ximian Evolution 1.0.8-3mdk 
Date: 30 Dec 2002 11:45:44 -0600
Message-Id: <1041270344.11712.7.camel@garaged.fis.unam.mx>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GgnW0JICjLKqXlKh/n3x
Content-Type: multipart/mixed; boundary="=-iOZY2yUDbxtRVBwrpNOF"


--=-iOZY2yUDbxtRVBwrpNOF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Here is the log of the errors on make modules_install, and the config
file
Any help apreciated !
Best regards, and a great Happy new Year
Max
--=20
uname -a: Linux garaged.fis.unam.mx 2.4.20-rc2-ac3 #2 SMP Thu Nov 21
17:15:31 UTC 2002 i686 unknown unknown GNU/Linux
-----BEGIN GEEK CODE BLOCK-----
GS/
d-s:a-C++ILIHA+++P-L++E--W++N+K-w++++O-M--V--PS+PEY+PGP-tXRtv++b+DI--D+Ge++=
h---r+++z+++
-----END GEEK CODE BLOCK-----
gpg-key: http://garaged.homeip.net/gpg-key.txt

--=-iOZY2yUDbxtRVBwrpNOF
Content-Disposition: attachment; filename=log
Content-Type: text/plain; name=log; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

cp: warning: source file `sound/oss/ad1848.ko' specified more than once
cp: warning: source file `sound/oss/sb_lib.ko' specified more than once
cp: warning: source file `sound/oss/uart401.ko' specified more than once
cp: warning: source file `sound/oss/sound.ko' specified more than once
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/drivers/block/=
floppy.ko
depmod: 	__alloc_pages
depmod: 	platform_device_unregister
depmod: 	blk_unregister_region
depmod: 	__wake_up
depmod: 	alloc_disk
depmod: 	get_disk
depmod: 	page_address
depmod: 	schedule
depmod: 	add_disk_randomness
depmod: 	__release_region
depmod: 	check_disk_change
depmod: 	blk_cleanup_queue
depmod: 	generic_unplug_device
depmod: 	elv_next_request
depmod: 	kmalloc
depmod: 	free_dma
depmod: 	end_that_request_last
depmod: 	submit_bio
depmod: 	get_options
depmod: 	__get_free_pages
depmod: 	vfree
depmod: 	default_wake_function
depmod: 	__check_disk_change
depmod: 	unregister_blkdev
depmod: 	enable_hlt
depmod: 	permission
depmod: 	complete
depmod: 	free_irq
depmod: 	remove_wait_queue
depmod: 	high_memory
depmod: 	register_blkdev
depmod: 	copy_to_user
depmod: 	rtc_lock
depmod: 	bdget
depmod: 	end_that_request_first
depmod: 	elv_remove_request
depmod: 	free_pages
depmod: 	del_gendisk
depmod: 	request_dma
depmod: 	add_disk
depmod: 	del_timer
depmod: 	bio_init
depmod: 	kfree
depmod: 	vmalloc
depmod: 	wait_for_completion
depmod: 	request_irq
depmod: 	flush_scheduled_work
depmod: 	platform_device_register
depmod: 	dma_spin_lock
depmod: 	add_wait_queue
depmod: 	blk_init_queue
depmod: 	contig_page_data
depmod: 	sprintf
depmod: 	__invalidate_buffers
depmod: 	copy_from_user
depmod: 	schedule_work
depmod: 	jiffies
depmod: 	__free_pages
depmod: 	__request_region
depmod: 	printk
depmod: 	add_timer
depmod: 	blk_register_region
depmod: 	__const_udelay
depmod: 	ioport_resource
depmod: 	put_disk
depmod: 	disable_hlt
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/drivers/block/=
loop.ko
depmod: 	bio_endio
depmod: 	flush_signals
depmod: 	balance_dirty_pages_ratelimited
depmod: 	alloc_disk
depmod: 	blk_queue_max_segment_size
depmod: 	bio_copy
depmod: 	invalidate_bdev
depmod: 	blk_queue_bounce
depmod: 	page_address
depmod: 	blk_max_low_pfn
depmod: 	unlock_page
depmod: 	blk_queue_merge_bvec
depmod: 	kmalloc
depmod: 	__down_failed_interruptible
depmod: 	blk_queue_max_sectors
depmod: 	__up_wakeup
depmod: 	set_user_nice
depmod: 	blk_queue_max_hw_segments
depmod: 	__page_cache_release
depmod: 	unregister_blkdev
depmod: 	kunmap
depmod: 	register_blkdev
depmod: 	copy_to_user
depmod: 	bio_put
depmod: 	blk_queue_make_request
depmod: 	del_gendisk
depmod: 	add_disk
depmod: 	blk_queue_bounce_limit
depmod: 	kfree
depmod: 	vfs_getattr
depmod: 	find_or_create_page
depmod: 	fput
depmod: 	set_blocksize
depmod: 	set_device_ro
depmod: 	sprintf
depmod: 	copy_from_user
depmod: 	daemonize
depmod: 	fget
depmod: 	bdev_read_only
depmod: 	generic_make_request
depmod: 	__free_pages
depmod: 	printk
depmod: 	kernel_thread
depmod: 	put_disk
depmod: 	blk_queue_max_phys_segments
depmod: 	kmap
depmod: 	blk_queue_segment_boundary
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/drivers/block/=
nbd.ko
depmod: 	bio_endio
depmod: 	alloc_disk
depmod: 	sock_sendmsg
depmod: 	page_address
depmod: 	blk_cleanup_queue
depmod: 	elv_next_request
depmod: 	__up_wakeup
depmod: 	blk_put_request
depmod: 	unregister_blkdev
depmod: 	register_blkdev
depmod: 	elv_remove_request
depmod: 	del_gendisk
depmod: 	add_disk
depmod: 	dequeue_signal
depmod: 	sock_recvmsg
depmod: 	fput
depmod: 	blk_init_queue
depmod: 	sprintf
depmod: 	fget
depmod: 	printk
depmod: 	put_disk
depmod: 	elv_queue_empty
depmod: 	recalc_sigpending
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/drivers/block/=
rd.ko
depmod: 	bio_endio
depmod: 	alloc_disk
depmod: 	invalidate_bdev
depmod: 	unlock_page
depmod: 	__up_wakeup
depmod: 	find_get_page
depmod: 	blkdev_put
depmod: 	unregister_blkdev
depmod: 	kunmap
depmod: 	register_blkdev
depmod: 	blk_queue_make_request
depmod: 	del_gendisk
depmod: 	add_disk
depmod: 	kunmap_atomic
depmod: 	find_or_create_page
depmod: 	sprintf
depmod: 	__free_pages
depmod: 	truncate_inode_pages
depmod: 	printk
depmod: 	kmap_atomic
depmod: 	put_disk
depmod: 	kmap
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/drivers/media/=
video/bw-qcam.ko
depmod: 	schedule_timeout
depmod: 	video_devdata
depmod: 	video_exclusive_release
depmod: 	schedule
depmod: 	kmalloc
depmod: 	__up_wakeup
depmod: 	no_llseek
depmod: 	video_register_device
depmod: 	video_unregister_device
depmod: 	copy_to_user
depmod: 	video_usercopy
depmod: 	video_exclusive_open
depmod: 	kfree
depmod: 	simple_strtoul
depmod: 	printk
depmod: 	__const_udelay
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/drivers/media/=
video/c-qcam.ko
depmod: 	__copy_to_user
depmod: 	schedule_timeout
depmod: 	video_devdata
depmod: 	video_exclusive_release
depmod: 	schedule
depmod: 	kmalloc
depmod: 	__up_wakeup
depmod: 	no_llseek
depmod: 	video_register_device
depmod: 	video_unregister_device
depmod: 	__cond_resched
depmod: 	video_usercopy
depmod: 	video_exclusive_open
depmod: 	kfree
depmod: 	jiffies
depmod: 	printk
depmod: 	__const_udelay
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/drivers/media/=
video/cpia.ko
depmod: 	remap_page_range
depmod: 	schedule_timeout
depmod: 	video_devdata
depmod: 	page_address
depmod: 	kmalloc
depmod: 	__down_failed_interruptible
depmod: 	_ctype
depmod: 	__up_wakeup
depmod: 	create_proc_entry
depmod: 	__get_free_pages
depmod: 	vfree
depmod: 	no_llseek
depmod: 	video_register_device
depmod: 	video_unregister_device
depmod: 	__cond_resched
depmod: 	vmalloc_32
depmod: 	copy_to_user
depmod: 	video_usercopy
depmod: 	free_pages
depmod: 	request_module
depmod: 	kfree
depmod: 	remove_proc_entry
depmod: 	simple_strtoul
depmod: 	sprintf
depmod: 	copy_from_user
depmod: 	jiffies
depmod: 	printk
depmod: 	vmalloc_to_page
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/drivers/media/=
video/cpia_usb.ko
depmod: 	__wake_up
depmod: 	kmalloc
depmod: 	vfree
depmod: 	interruptible_sleep_on
depmod: 	kfree
depmod: 	vmalloc
depmod: 	printk
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/drivers/media/=
video/pms.ko
depmod: 	video_devdata
depmod: 	video_exclusive_release
depmod: 	__release_region
depmod: 	__up_wakeup
depmod: 	no_llseek
depmod: 	video_register_device
depmod: 	video_unregister_device
depmod: 	copy_to_user
depmod: 	video_usercopy
depmod: 	video_exclusive_open
depmod: 	__request_region
depmod: 	printk
depmod: 	ioport_resource
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/drivers/messag=
e/i2o/i2o_config.ko
depmod: 	__copy_to_user
depmod: 	__get_user_4
depmod: 	misc_deregister
depmod: 	dma_alloc_coherent
depmod: 	kmalloc
depmod: 	kernel_flag
depmod: 	no_llseek
depmod: 	copy_to_user
depmod: 	pci_set_dma_mask
depmod: 	kfree
depmod: 	misc_register
depmod: 	__copy_from_user
depmod: 	kill_fasync
depmod: 	fasync_helper
depmod: 	copy_from_user
depmod: 	printk
depmod: 	dma_free_coherent
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/drivers/messag=
e/i2o/i2o_core.ko
depmod: 	schedule_timeout
depmod: 	yield
depmod: 	__wake_up
depmod: 	schedule
depmod: 	pci_find_parent_resource
depmod: 	dma_alloc_coherent
depmod: 	kmalloc
depmod: 	__down_failed_interruptible
depmod: 	__up_wakeup
depmod: 	kernel_flag
depmod: 	default_wake_function
depmod: 	remove_wait_queue
depmod: 	kill_proc
depmod: 	allocate_resource
depmod: 	kfree
depmod: 	unregister_reboot_notifier
depmod: 	wait_for_completion
depmod: 	add_wait_queue
depmod: 	sprintf
depmod: 	daemonize
depmod: 	jiffies
depmod: 	printk
depmod: 	complete_and_exit
depmod: 	kernel_thread
depmod: 	dma_free_coherent
depmod: 	__down_failed
depmod: 	register_reboot_notifier
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/drivers/messag=
e/i2o/i2o_proc.ko
depmod: 	kmalloc
depmod: 	create_proc_entry
depmod: 	proc_mkdir
depmod: 	kfree
depmod: 	remove_proc_entry
depmod: 	sprintf
depmod: 	printk
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/drivers/messag=
e/i2o/i2o_scsi.ko
depmod: 	schedule_timeout
depmod: 	kmalloc
depmod: 	del_timer
depmod: 	kfree
depmod: 	mem_map
depmod: 	jiffies
depmod: 	printk
depmod: 	add_timer
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/drivers/net/3c=
59x.ko
depmod: 	pci_set_power_state
depmod: 	__netdev_watchdog_up
depmod: 	enable_irq
depmod: 	eth_type_trans
depmod: 	del_timer_sync
depmod: 	__kfree_skb
depmod: 	alloc_skb
depmod: 	pci_register_driver
depmod: 	page_address
depmod: 	pci_bus_write_config_byte
depmod: 	__release_region
depmod: 	dma_alloc_coherent
depmod: 	pci_enable_device
depmod: 	alloc_etherdev
depmod: 	cpu_raise_softirq
depmod: 	pci_restore_state
depmod: 	free_irq
depmod: 	unregister_netdev
depmod: 	copy_to_user
depmod: 	__ioremap
depmod: 	register_netdev
depmod: 	linkwatch_fire_event
depmod: 	mod_timer
depmod: 	kfree
depmod: 	disable_irq
depmod: 	request_irq
depmod: 	netif_rx
depmod: 	pci_unregister_driver
depmod: 	skb_over_panic
depmod: 	pci_set_master
depmod: 	pci_enable_wake
depmod: 	sprintf
depmod: 	copy_from_user
depmod: 	jiffies
depmod: 	softnet_data
depmod: 	__request_region
depmod: 	printk
depmod: 	add_timer
depmod: 	irq_stat
depmod: 	pci_save_state
depmod: 	__const_udelay
depmod: 	ioport_resource
depmod: 	do_softirq
depmod: 	dma_free_coherent
depmod: 	pci_bus_read_config_byte
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/drivers/net/du=
mmy.ko
depmod: 	__kfree_skb
depmod: 	ether_setup
depmod: 	kmalloc
depmod: 	unregister_netdev
depmod: 	register_netdev
depmod: 	dev_alloc_name
depmod: 	kfree
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/drivers/parpor=
t/parport.ko
depmod: 	schedule_timeout
depmod: 	__wake_up
depmod: 	schedule
depmod: 	__write_lock_failed
depmod: 	kmalloc
depmod: 	__down_failed_interruptible
depmod: 	__up_wakeup
depmod: 	copy_to_user
depmod: 	proc_doulongvec_ms_jiffies_minmax
depmod: 	request_module
depmod: 	unregister_sysctl_table
depmod: 	del_timer
depmod: 	interruptible_sleep_on
depmod: 	kfree
depmod: 	simple_strtoul
depmod: 	sprintf
depmod: 	jiffies
depmod: 	proc_dointvec_minmax
depmod: 	printk
depmod: 	add_timer
depmod: 	__const_udelay
depmod: 	register_sysctl_table
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/drivers/parpor=
t/parport_pc.ko
depmod: 	pci_register_driver
depmod: 	pci_bus_write_config_byte
depmod: 	__release_region
depmod: 	pci_bus_read_config_dword
depmod: 	kmalloc
depmod: 	probe_irq_off
depmod: 	pnp_register_driver
depmod: 	pci_enable_device
depmod: 	free_dma
depmod: 	__check_region
depmod: 	free_irq
depmod: 	pci_match_device
depmod: 	__read_lock_failed
depmod: 	kfree
depmod: 	pci_devices
depmod: 	request_irq
depmod: 	pci_unregister_driver
depmod: 	__request_region
depmod: 	printk
depmod: 	pnp_unregister_driver
depmod: 	ioport_resource
depmod: 	pci_bus_write_config_dword
depmod: 	pci_bus_read_config_byte
depmod: 	probe_irq_on
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/drivers/scsi/a=
ic7xxx/aic7xxx.ko
depmod: 	pci_set_power_state
depmod: 	strsep
depmod: 	pci_register_driver
depmod: 	pci_bus_write_config_byte
depmod: 	__udelay
depmod: 	__release_region
depmod: 	vsprintf
depmod: 	dma_alloc_coherent
depmod: 	pci_bus_read_config_dword
depmod: 	kmalloc
depmod: 	si_meminfo
depmod: 	pci_enable_device
depmod: 	__up_wakeup
depmod: 	__tasklet_schedule
depmod: 	__check_region
depmod: 	simple_strtol
depmod: 	free_irq
depmod: 	tasklet_kill
depmod: 	panic
depmod: 	ioremap_nocache
depmod: 	iounmap
depmod: 	del_timer
depmod: 	mod_timer
depmod: 	iomem_resource
depmod: 	pci_set_dma_mask
depmod: 	kfree
depmod: 	unregister_reboot_notifier
depmod: 	request_irq
depmod: 	pci_bus_read_config_word
depmod: 	pci_unregister_driver
depmod: 	pci_set_master
depmod: 	mem_map
depmod: 	simple_strtoul
depmod: 	sprintf
depmod: 	jiffies
depmod: 	tasklet_init
depmod: 	__request_region
depmod: 	printk
depmod: 	add_timer
depmod: 	kernel_thread
depmod: 	ioport_resource
depmod: 	pci_bus_write_config_dword
depmod: 	dma_free_coherent
depmod: 	pci_bus_read_config_byte
depmod: 	__down_failed
depmod: 	register_reboot_notifier
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/drivers/scsi/i=
de-scsi.ko
depmod: 	schedule_timeout
depmod: 	ide_end_drive_cmd
depmod: 	ide_wait_stat
depmod: 	blk_dump_rq_flags
depmod: 	page_address
depmod: 	ide_do_reset
depmod: 	elv_next_request
depmod: 	kmalloc
depmod: 	atapi_output_bytes
depmod: 	end_that_request_last
depmod: 	ide_lock
depmod: 	ide_unregister_driver
depmod: 	bio_put
depmod: 	generic_ide_ioctl
depmod: 	ide_unregister_subdriver
depmod: 	elv_remove_request
depmod: 	bus_unregister
depmod: 	device_unregister
depmod: 	atapi_input_bytes
depmod: 	bus_register
depmod: 	bio_alloc
depmod: 	strstr
depmod: 	ide_do_drive_cmd
depmod: 	bio_init
depmod: 	kfree
depmod: 	ide_set_handler
depmod: 	ide_register_subdriver
depmod: 	ide_register_driver
depmod: 	ide_fops
depmod: 	mem_map
depmod: 	ide_init_drive_cmd
depmod: 	ide_add_setting
depmod: 	device_register
depmod: 	jiffies
depmod: 	SELECT_DRIVE
depmod: 	printk
depmod: 	ide_end_request
depmod: 	elv_queue_empty
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/drivers/scsi/i=
mm.ko
depmod: 	page_address
depmod: 	schedule
depmod: 	schedule_delayed_work
depmod: 	simple_strtoul
depmod: 	sprintf
depmod: 	schedule_work
depmod: 	jiffies
depmod: 	printk
depmod: 	__const_udelay
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/drivers/scsi/p=
pa.ko
depmod: 	page_address
depmod: 	schedule
depmod: 	schedule_delayed_work
depmod: 	simple_strtoul
depmod: 	sprintf
depmod: 	schedule_work
depmod: 	jiffies
depmod: 	printk
depmod: 	__const_udelay
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/drivers/scsi/s=
csi_mod.ko
depmod: 	send_sig
depmod: 	mempool_free_slab
depmod: 	__get_user_1
depmod: 	__get_user_4
depmod: 	mempool_alloc_slab
depmod: 	strsep
depmod: 	blk_dump_rq_flags
depmod: 	__wake_up
depmod: 	scsi_command_size
depmod: 	schedule
depmod: 	add_disk_randomness
depmod: 	__release_region
depmod: 	blk_max_low_pfn
depmod: 	blk_cleanup_queue
depmod: 	generic_unplug_device
depmod: 	elv_next_request
depmod: 	snprintf
depmod: 	kmalloc
depmod: 	__down_failed_interruptible
depmod: 	driver_unregister
depmod: 	free_dma
depmod: 	end_that_request_last
depmod: 	blk_queue_max_sectors
depmod: 	__up_wakeup
depmod: 	open_softirq
depmod: 	blk_queue_max_hw_segments
depmod: 	create_proc_entry
depmod: 	__blk_run_queue
depmod: 	blk_nohighio
depmod: 	kernel_flag
depmod: 	__bread
depmod: 	__get_free_pages
depmod: 	default_wake_function
depmod: 	cpu_raise_softirq
depmod: 	mempool_free
depmod: 	complete
depmod: 	free_irq
depmod: 	remove_wait_queue
depmod: 	devclass_register
depmod: 	panic
depmod: 	copy_to_user
depmod: 	mempool_alloc
depmod: 	device_remove_file
depmod: 	end_that_request_first
depmod: 	blk_insert_request
depmod: 	elv_remove_request
depmod: 	free_pages
depmod: 	bus_unregister
depmod: 	request_module
depmod: 	strpbrk
depmod: 	proc_mkdir
depmod: 	blk_rq_map_sg
depmod: 	kmem_cache_create
depmod: 	device_unregister
depmod: 	devclass_unregister
depmod: 	bus_register
depmod: 	strstr
depmod: 	del_timer
depmod: 	kunmap_atomic
depmod: 	blk_max_pfn
depmod: 	dump_stack
depmod: 	blk_queue_bounce_limit
depmod: 	kfree
depmod: 	device_create_file
depmod: 	wait_for_completion
depmod: 	__copy_from_user
depmod: 	remove_proc_entry
depmod: 	rwsem_down_write_failed
depmod: 	rwsem_wake
depmod: 	blk_queue_prep_rq
depmod: 	add_wait_queue
depmod: 	blk_init_queue
depmod: 	simple_strtoul
depmod: 	blk_queue_end_tag
depmod: 	sprintf
depmod: 	blk_queue_start_tag
depmod: 	kmem_cache_destroy
depmod: 	__brelse
depmod: 	copy_from_user
depmod: 	daemonize
depmod: 	device_register
depmod: 	__elv_add_request
depmod: 	jiffies
depmod: 	mempool_destroy
depmod: 	blk_plug_device
depmod: 	printk
depmod: 	add_timer
depmod: 	driver_register
depmod: 	kmap_atomic
depmod: 	kernel_thread
depmod: 	__const_udelay
depmod: 	ioport_resource
depmod: 	rwsem_down_read_failed
depmod: 	blk_queue_max_phys_segments
depmod: 	elv_queue_empty
depmod: 	mempool_create
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/drivers/scsi/s=
d_mod.ko
depmod: 	schedule_timeout
depmod: 	alloc_disk
depmod: 	check_disk_change
depmod: 	kmalloc
depmod: 	unregister_blkdev
depmod: 	register_blkdev
depmod: 	del_gendisk
depmod: 	scsi_cmd_ioctl
depmod: 	add_disk
depmod: 	kfree
depmod: 	unregister_reboot_notifier
depmod: 	sprintf
depmod: 	blk_queue_hardsect_size
depmod: 	jiffies
depmod: 	printk
depmod: 	put_disk
depmod: 	register_reboot_notifier
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/drivers/scsi/s=
g.ko
depmod: 	__copy_to_user
depmod: 	__get_user_4
depmod: 	__wake_up
depmod: 	alloc_disk
depmod: 	scsi_command_size
depmod: 	page_address
depmod: 	schedule
depmod: 	__write_lock_failed
depmod: 	generic_unplug_device
depmod: 	kmalloc
depmod: 	unregister_chrdev
depmod: 	register_chrdev
depmod: 	create_proc_entry
depmod: 	__get_free_pages
depmod: 	vfree
depmod: 	default_wake_function
depmod: 	__page_cache_release
depmod: 	remove_wait_queue
depmod: 	copy_to_user
depmod: 	device_remove_file
depmod: 	free_pages
depmod: 	device_unregister
depmod: 	__read_lock_failed
depmod: 	kfree
depmod: 	device_create_file
depmod: 	vmalloc
depmod: 	__copy_from_user
depmod: 	remove_proc_entry
depmod: 	rwsem_wake
depmod: 	kill_fasync
depmod: 	get_user_pages
depmod: 	fasync_helper
depmod: 	add_wait_queue
depmod: 	mem_map
depmod: 	simple_strtoul
depmod: 	sprintf
depmod: 	copy_from_user
depmod: 	device_register
depmod: 	jiffies
depmod: 	printk
depmod: 	rwsem_down_read_failed
depmod: 	put_disk
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/drivers/scsi/s=
r_mod.ko
depmod: 	blk_dump_rq_flags
depmod: 	alloc_disk
depmod: 	cdrom_open
depmod: 	cdrom_release
depmod: 	register_cdrom
depmod: 	cdrom_ioctl
depmod: 	kmalloc
depmod: 	unregister_blkdev
depmod: 	register_blkdev
depmod: 	cdrom_media_changed
depmod: 	unregister_cdrom
depmod: 	del_gendisk
depmod: 	add_disk
depmod: 	kfree
depmod: 	cdrom_number_of_slots
depmod: 	sprintf
depmod: 	blk_queue_hardsect_size
depmod: 	printk
depmod: 	put_disk
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/drivers/scsi/s=
t.ko
depmod: 	__alloc_pages
depmod: 	schedule_timeout
depmod: 	alloc_disk
depmod: 	page_address
depmod: 	__write_lock_failed
depmod: 	kmalloc
depmod: 	unregister_chrdev
depmod: 	register_chrdev
depmod: 	__down_failed_interruptible
depmod: 	__up_wakeup
depmod: 	__page_cache_release
depmod: 	complete
depmod: 	panic
depmod: 	copy_to_user
depmod: 	device_remove_file
depmod: 	device_unregister
depmod: 	kfree
depmod: 	device_create_file
depmod: 	wait_for_completion
depmod: 	rwsem_wake
depmod: 	get_user_pages
depmod: 	contig_page_data
depmod: 	mem_map
depmod: 	sprintf
depmod: 	copy_from_user
depmod: 	device_register
depmod: 	__free_pages
depmod: 	printk
depmod: 	rwsem_down_read_failed
depmod: 	put_disk
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/drivers/scsi/s=
ym53c8xx.ko
depmod: 	pci_bus_write_config_word
depmod: 	pci_bus_write_config_byte
depmod: 	__release_region
depmod: 	vsprintf
depmod: 	dma_alloc_coherent
depmod: 	pci_bus_read_config_dword
depmod: 	pci_enable_device
depmod: 	__check_region
depmod: 	__get_free_pages
depmod: 	free_irq
depmod: 	panic
depmod: 	iounmap
depmod: 	free_pages
depmod: 	__ioremap
depmod: 	pci_set_dma_mask
depmod: 	pci_devices
depmod: 	request_irq
depmod: 	pci_bus_read_config_word
depmod: 	pci_find_device
depmod: 	mem_map
depmod: 	simple_strtoul
depmod: 	sprintf
depmod: 	jiffies
depmod: 	__request_region
depmod: 	printk
depmod: 	add_timer
depmod: 	__const_udelay
depmod: 	ioport_resource
depmod: 	dma_free_coherent
depmod: 	pci_bus_read_config_byte
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/drivers/usb/cl=
ass/cdc-acm.ko
depmod: 	__get_user_4
depmod: 	__wake_up
depmod: 	tty_unregister_driver
depmod: 	tty_std_termios
depmod: 	kmalloc
depmod: 	tty_register_driver
depmod: 	kernel_flag
depmod: 	tty_unregister_devfs
depmod: 	tty_register_devfs
depmod: 	kfree
depmod: 	tty_flip_buffer_push
depmod: 	tty_hangup
depmod: 	copy_from_user
depmod: 	schedule_work
depmod: 	printk
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/drivers/usb/cl=
ass/usblp.ko
depmod: 	schedule_timeout
depmod: 	__wake_up
depmod: 	schedule
depmod: 	kmalloc
depmod: 	__up_wakeup
depmod: 	kernel_flag
depmod: 	default_wake_function
depmod: 	remove_wait_queue
depmod: 	copy_to_user
depmod: 	kfree
depmod: 	add_wait_queue
depmod: 	sprintf
depmod: 	copy_from_user
depmod: 	printk
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/drivers/usb/co=
re/usbcore.ko
depmod: 	dput
depmod: 	pci_set_power_state
depmod: 	__down_failed_trylock
depmod: 	generic_delete_inode
depmod: 	__get_user_4
depmod: 	schedule_timeout
depmod: 	d_delete
depmod: 	del_timer_sync
depmod: 	strsep
depmod: 	__wake_up
depmod: 	init_special_inode
depmod: 	simple_lookup
depmod: 	lookup_hash
depmod: 	schedule
depmod: 	__release_region
depmod: 	dma_alloc_coherent
depmod: 	snprintf
depmod: 	kmalloc
depmod: 	unregister_chrdev
depmod: 	new_inode
depmod: 	register_chrdev
depmod: 	driver_unregister
depmod: 	pci_enable_device
depmod: 	__up_wakeup
depmod: 	kernel_flag
depmod: 	proc_bus
depmod: 	__get_free_pages
depmod: 	default_wake_function
depmod: 	current_kernel_time
depmod: 	unregister_filesystem
depmod: 	iput
depmod: 	dcache_lock
depmod: 	send_sig_info
depmod: 	pci_restore_state
depmod: 	complete
depmod: 	free_irq
depmod: 	remove_wait_queue
depmod: 	__mntput
depmod: 	pci_pool_free
depmod: 	kill_proc
depmod: 	copy_to_user
depmod: 	ioremap_nocache
depmod: 	iounmap
depmod: 	register_filesystem
depmod: 	free_pages
depmod: 	get_sb_single
depmod: 	bus_unregister
depmod: 	proc_mkdir
depmod: 	device_unregister
depmod: 	bus_register
depmod: 	pci_pool_alloc
depmod: 	d_alloc_root
depmod: 	iomem_resource
depmod: 	simple_statfs
depmod: 	kfree
depmod: 	pci_pool_destroy
depmod: 	device_create_file
depmod: 	wait_for_completion
depmod: 	remove_proc_entry
depmod: 	rwsem_down_write_failed
depmod: 	rwsem_wake
depmod: 	request_irq
depmod: 	kill_litter_super
depmod: 	pci_pool_create
depmod: 	flush_scheduled_work
depmod: 	add_wait_queue
depmod: 	pci_set_master
depmod: 	mem_map
depmod: 	simple_strtoul
depmod: 	shrink_dcache_parent
depmod: 	kern_mount
depmod: 	sprintf
depmod: 	copy_from_user
depmod: 	daemonize
depmod: 	schedule_work
depmod: 	device_register
depmod: 	jiffies
depmod: 	d_instantiate
depmod: 	__request_region
depmod: 	printk
depmod: 	add_timer
depmod: 	complete_and_exit
depmod: 	driver_register
depmod: 	pci_save_state
depmod: 	kernel_thread
depmod: 	__const_udelay
depmod: 	ioport_resource
depmod: 	simple_dir_operations
depmod: 	rwsem_down_read_failed
depmod: 	dma_free_coherent
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/drivers/usb/ho=
st/ohci-hcd.ko
depmod: 	pci_bus_write_config_word
depmod: 	schedule_timeout
depmod: 	pci_register_driver
depmod: 	dma_alloc_coherent
depmod: 	snprintf
depmod: 	kmalloc
depmod: 	pci_pool_free
depmod: 	device_remove_file
depmod: 	pci_pool_alloc
depmod: 	kfree
depmod: 	pci_pool_destroy
depmod: 	device_create_file
depmod: 	pci_bus_read_config_word
depmod: 	pci_pool_create
depmod: 	pci_unregister_driver
depmod: 	pci_set_master
depmod: 	printk
depmod: 	__const_udelay
depmod: 	dma_free_coherent
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/drivers/usb/ho=
st/uhci-hcd.ko
depmod: 	pci_bus_write_config_word
depmod: 	schedule_timeout
depmod: 	del_timer_sync
depmod: 	pci_register_driver
depmod: 	kmem_cache_free
depmod: 	dma_alloc_coherent
depmod: 	kmalloc
depmod: 	create_proc_entry
depmod: 	kernel_flag
depmod: 	pci_pool_free
depmod: 	copy_to_user
depmod: 	kmem_cache_create
depmod: 	pci_pool_alloc
depmod: 	kfree
depmod: 	pci_pool_destroy
depmod: 	remove_proc_entry
depmod: 	pci_pool_create
depmod: 	pci_unregister_driver
depmod: 	pci_set_master
depmod: 	sprintf
depmod: 	kmem_cache_destroy
depmod: 	jiffies
depmod: 	printk
depmod: 	add_timer
depmod: 	__const_udelay
depmod: 	kmem_cache_alloc
depmod: 	dma_free_coherent
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/drivers/usb/im=
age/scanner.ko
depmod: 	kmalloc
depmod: 	__up_wakeup
depmod: 	current_kernel_time
depmod: 	copy_to_user
depmod: 	interruptible_sleep_on_timeout
depmod: 	kfree
depmod: 	sprintf
depmod: 	copy_from_user
depmod: 	printk
depmod: 	__const_udelay
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/drivers/usb/in=
put/hid.ko
depmod: 	schedule_timeout
depmod: 	__wake_up
depmod: 	snprintf
depmod: 	kmalloc
depmod: 	default_wake_function
depmod: 	remove_wait_queue
depmod: 	kfree
depmod: 	add_wait_queue
depmod: 	printk
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/drivers/usb/st=
orage/usb-storage.ko
depmod: 	flush_signals
depmod: 	schedule_timeout
depmod: 	page_address
depmod: 	kmalloc
depmod: 	__down_failed_interruptible
depmod: 	__up_wakeup
depmod: 	kernel_flag
depmod: 	complete
depmod: 	dump_stack
depmod: 	kfree
depmod: 	wait_for_completion
depmod: 	sprintf
depmod: 	daemonize
depmod: 	printk
depmod: 	kernel_thread
depmod: 	__const_udelay
depmod: 	recalc_sigpending
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/fs/autofs/auto=
fs.ko
depmod: 	dput
depmod: 	__get_user_4
depmod: 	strsep
depmod: 	__wake_up
depmod: 	unlock_new_inode
depmod: 	kmalloc
depmod: 	generic_read_dir
depmod: 	__up_wakeup
depmod: 	kill_anon_super
depmod: 	kernel_flag
depmod: 	current_kernel_time
depmod: 	unregister_filesystem
depmod: 	vfs_readlink
depmod: 	iput
depmod: 	dcache_lock
depmod: 	__mntput
depmod: 	d_rehash
depmod: 	copy_to_user
depmod: 	iget_locked
depmod: 	register_filesystem
depmod: 	d_alloc_root
depmod: 	get_sb_nodev
depmod: 	interruptible_sleep_on
depmod: 	simple_statfs
depmod: 	kfree
depmod: 	may_umount
depmod: 	simple_dir_inode_operations
depmod: 	vfs_follow_link
depmod: 	fput
depmod: 	xtime
depmod: 	simple_strtoul
depmod: 	fget
depmod: 	jiffies
depmod: 	d_instantiate
depmod: 	printk
depmod: 	simple_dir_operations
depmod: 	follow_down
depmod: 	recalc_sigpending
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/fs/autofs4/aut=
ofs4.ko
depmod: 	dput
depmod: 	__get_user_4
depmod: 	strsep
depmod: 	__wake_up
depmod: 	update_atime
depmod: 	kmalloc
depmod: 	dcache_readdir
depmod: 	new_inode
depmod: 	generic_read_dir
depmod: 	__up_wakeup
depmod: 	kill_anon_super
depmod: 	kernel_flag
depmod: 	current_kernel_time
depmod: 	unregister_filesystem
depmod: 	vfs_readlink
depmod: 	iput
depmod: 	dcache_lock
depmod: 	d_rehash
depmod: 	copy_to_user
depmod: 	register_filesystem
depmod: 	dcache_dir_close
depmod: 	d_alloc_root
depmod: 	get_sb_nodev
depmod: 	interruptible_sleep_on
depmod: 	simple_statfs
depmod: 	kfree
depmod: 	shrink_dcache_sb
depmod: 	dcache_dir_lseek
depmod: 	vfs_follow_link
depmod: 	fput
depmod: 	simple_strtoul
depmod: 	lookup_mnt
depmod: 	dcache_dir_open
depmod: 	fget
depmod: 	jiffies
depmod: 	d_instantiate
depmod: 	printk
depmod: 	simple_dir_operations
depmod: 	recalc_sigpending
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/fs/coda/coda.k=
o
depmod: 	dput
depmod: 	d_delete
depmod: 	__wake_up
depmod: 	proc_root_fs
depmod: 	init_special_inode
depmod: 	generic_file_llseek
depmod: 	path_release
depmod: 	kmem_cache_free
depmod: 	schedule
depmod: 	unlock_page
depmod: 	d_prune_aliases
depmod: 	page_follow_link
depmod: 	unlock_new_inode
depmod: 	kmalloc
depmod: 	unregister_chrdev
depmod: 	new_inode
depmod: 	generic_read_dir
depmod: 	register_chrdev
depmod: 	__up_wakeup
depmod: 	create_proc_entry
depmod: 	kill_anon_super
depmod: 	kernel_flag
depmod: 	vfree
depmod: 	default_wake_function
depmod: 	current_kernel_time
depmod: 	unregister_filesystem
depmod: 	iput
depmod: 	dcache_lock
depmod: 	remove_wait_queue
depmod: 	find_inode_number
depmod: 	kunmap
depmod: 	d_find_alias
depmod: 	is_bad_inode
depmod: 	d_rehash
depmod: 	inode_init_once
depmod: 	copy_to_user
depmod: 	generic_fillattr
depmod: 	register_filesystem
depmod: 	remove_inode_hash
depmod: 	proc_mkdir
depmod: 	kmem_cache_create
depmod: 	d_alloc_root
depmod: 	proc_dointvec
depmod: 	unregister_sysctl_table
depmod: 	get_sb_nodev
depmod: 	kfree
depmod: 	shrink_dcache_sb
depmod: 	vmalloc
depmod: 	remove_proc_entry
depmod: 	page_readlink
depmod: 	add_wait_queue
depmod: 	__user_walk
depmod: 	fput
depmod: 	kernel_read
depmod: 	shrink_dcache_parent
depmod: 	sprintf
depmod: 	kmem_cache_destroy
depmod: 	copy_from_user
depmod: 	fget
depmod: 	jiffies
depmod: 	d_instantiate
depmod: 	printk
depmod: 	register_sysctl_table
depmod: 	kmem_cache_alloc
depmod: 	iget5_locked
depmod: 	__insert_inode_hash
depmod: 	kmap
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/fs/cramfs/cram=
fs.ko
depmod: 	init_special_inode
depmod: 	unlock_page
depmod: 	kmalloc
depmod: 	new_inode
depmod: 	generic_read_dir
depmod: 	__wait_on_buffer
depmod: 	__up_wakeup
depmod: 	kernel_flag
depmod: 	vfree
depmod: 	unregister_filesystem
depmod: 	kunmap
depmod: 	d_rehash
depmod: 	ll_rw_block
depmod: 	register_filesystem
depmod: 	__getblk
depmod: 	d_alloc_root
depmod: 	page_symlink_inode_operations
depmod: 	kfree
depmod: 	kill_block_super
depmod: 	vmalloc
depmod: 	sb_set_blocksize
depmod: 	generic_ro_fops
depmod: 	__brelse
depmod: 	d_instantiate
depmod: 	get_sb_bdev
depmod: 	printk
depmod: 	__insert_inode_hash
depmod: 	kmap
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/fs/exportfs/ex=
portfs.ko
depmod: 	dput
depmod: 	unlock_new_inode
depmod: 	__up_wakeup
depmod: 	kernel_flag
depmod: 	iput
depmod: 	dcache_lock
depmod: 	dget_locked
depmod: 	is_bad_inode
depmod: 	iget_locked
depmod: 	init_private_file
depmod: 	__read_lock_failed
depmod: 	d_alloc_anon
depmod: 	lookup_one_len
depmod: 	printk
depmod: 	dparent_lock
depmod: 	vfs_readdir
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/fs/ext3/ext3.k=
o
depmod: 	journal_init_inode
depmod: 	sb_min_blocksize
depmod: 	inode_setattr
depmod: 	journal_init_dev
depmod: 	dput
depmod: 	__down_failed_trylock
depmod: 	journal_force_commit
depmod: 	do_sync_read
depmod: 	mb_cache_shrink
depmod: 	journal_create
depmod: 	__get_user_4
depmod: 	__buffer_error
depmod: 	strsep
depmod: 	journal_dirty_data
depmod: 	in_group_p
depmod: 	mb_cache_destroy
depmod: 	init_special_inode
depmod: 	generic_file_llseek
depmod: 	invalidate_bdev
depmod: 	kmem_cache_free
depmod: 	log_wait_commit
depmod: 	journal_restart
depmod: 	__write_lock_failed
depmod: 	unlock_buffer
depmod: 	update_atime
depmod: 	block_prepare_write
depmod: 	vsprintf
depmod: 	unlock_page
depmod: 	generic_commit_write
depmod: 	clear_inode
depmod: 	mb_cache_entry_alloc
depmod: 	page_follow_link
depmod: 	unlock_new_inode
depmod: 	snprintf
depmod: 	kmalloc
depmod: 	journal_extend
depmod: 	new_inode
depmod: 	generic_read_dir
depmod: 	log_start_commit
depmod: 	__wait_on_buffer
depmod: 	generic_file_aio_read
depmod: 	__up_wakeup
depmod: 	rb_insert_color
depmod: 	mpage_readpage
depmod: 	kernel_flag
depmod: 	__bread
depmod: 	journal_update_format
depmod: 	blkdev_put
depmod: 	__mark_inode_dirty
depmod: 	__page_cache_release
depmod: 	__bdevname
depmod: 	current_kernel_time
depmod: 	unregister_filesystem
depmod: 	vfs_readlink
depmod: 	iput
depmod: 	fs_overflowuid
depmod: 	permission
depmod: 	journal_get_undo_access
depmod: 	journal_lock_updates
depmod: 	journal_errno
depmod: 	generic_file_mmap
depmod: 	is_bad_inode
depmod: 	d_rehash
depmod: 	make_bad_inode
depmod: 	panic
depmod: 	get_random_bytes
depmod: 	journal_flush
depmod: 	inode_init_once
depmod: 	journal_start
depmod: 	ll_rw_block
depmod: 	bdget
depmod: 	fs_overflowgid
depmod: 	journal_blocks_per_page
depmod: 	iget_locked
depmod: 	create_empty_buffers
depmod: 	journal_abort
depmod: 	register_filesystem
depmod: 	block_sync_page
depmod: 	mb_cache_entry_find_next
depmod: 	journal_clear_err
depmod: 	__getblk
depmod: 	generic_direct_IO
depmod: 	kmem_cache_create
depmod: 	__set_page_dirty_nobuffers
depmod: 	mb_cache_entry_release
depmod: 	journal_invalidatepage
depmod: 	d_alloc_root
depmod: 	journal_destroy
depmod: 	__read_lock_failed
depmod: 	sync_mapping_buffers
depmod: 	kunmap_atomic
depmod: 	generic_file_aio_write
depmod: 	mark_buffer_dirty
depmod: 	kfree
depmod: 	generic_file_sendfile
depmod: 	journal_check_available_features
depmod: 	kill_block_super
depmod: 	blkdev_get
depmod: 	d_alloc_anon
depmod: 	journal_load
depmod: 	journal_get_write_access
depmod: 	journal_revoke
depmod: 	journal_get_create_access
depmod: 	rwsem_down_write_failed
depmod: 	rwsem_wake
depmod: 	do_sync_write
depmod: 	mpage_readpages
depmod: 	page_readlink
depmod: 	generic_file_readv
depmod: 	journal_try_to_free_buffers
depmod: 	sb_set_blocksize
depmod: 	find_or_create_page
depmod: 	mb_cache_entry_find_first
depmod: 	vfs_follow_link
depmod: 	mb_cache_create
depmod: 	journal_try_start
depmod: 	set_blocksize
depmod: 	d_splice_alias
depmod: 	xtime
depmod: 	journal_stop
depmod: 	journal_wipe
depmod: 	simple_strtoul
depmod: 	sync_blockdev
depmod: 	kmem_cache_destroy
depmod: 	__brelse
depmod: 	bdev_read_only
depmod: 	__find_get_block
depmod: 	generic_file_writev
depmod: 	d_instantiate
depmod: 	mb_cache_entry_insert
depmod: 	mb_cache_entry_free
depmod: 	block_write_full_page
depmod: 	get_sb_bdev
depmod: 	inode_change_ok
depmod: 	printk
depmod: 	kmap_atomic
depmod: 	journal_unlock_updates
depmod: 	rb_next
depmod: 	mb_cache_entry_get
depmod: 	rb_first
depmod: 	kmem_cache_alloc
depmod: 	rwsem_down_read_failed
depmod: 	__insert_inode_hash
depmod: 	journal_forget
depmod: 	page_symlink
depmod: 	__down_failed
depmod: 	journal_dirty_metadata
depmod: 	generic_block_bmap
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/fs/fat/fat.ko
depmod: 	sb_min_blocksize
depmod: 	inode_setattr
depmod: 	__get_user_2
depmod: 	strsep
depmod: 	vsnprintf
depmod: 	generic_file_llseek
depmod: 	kmem_cache_free
depmod: 	load_nls
depmod: 	generic_file_write
depmod: 	generic_commit_write
depmod: 	clear_inode
depmod: 	unlock_new_inode
depmod: 	kmalloc
depmod: 	new_inode
depmod: 	generic_read_dir
depmod: 	__up_wakeup
depmod: 	load_nls_default
depmod: 	kernel_flag
depmod: 	__bread
depmod: 	__get_free_pages
depmod: 	__mark_inode_dirty
depmod: 	file_fsync
depmod: 	current_kernel_time
depmod: 	iput
depmod: 	block_read_full_page
depmod: 	kunmap
depmod: 	generic_file_mmap
depmod: 	is_bad_inode
depmod: 	make_bad_inode
depmod: 	inode_init_once
depmod: 	copy_to_user
depmod: 	generic_file_read
depmod: 	iget_locked
depmod: 	free_pages
depmod: 	block_sync_page
depmod: 	cont_prepare_write
depmod: 	__getblk
depmod: 	kmem_cache_create
depmod: 	unload_nls
depmod: 	d_alloc_root
depmod: 	sys_tz
depmod: 	__read_lock_failed
depmod: 	mark_buffer_dirty
depmod: 	kfree
depmod: 	generic_file_sendfile
depmod: 	d_alloc_anon
depmod: 	sb_set_blocksize
depmod: 	iunique
depmod: 	seq_printf
depmod: 	utf8_wcstombs
depmod: 	xtime
depmod: 	igrab
depmod: 	simple_strtoul
depmod: 	sprintf
depmod: 	kmem_cache_destroy
depmod: 	__brelse
depmod: 	block_write_full_page
depmod: 	inode_change_ok
depmod: 	printk
depmod: 	dparent_lock
depmod: 	kmem_cache_alloc
depmod: 	__insert_inode_hash
depmod: 	kmap
depmod: 	__down_failed
depmod: 	generic_block_bmap
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/fs/isofs/isofs=
.ko
depmod: 	__alloc_pages
depmod: 	sb_min_blocksize
depmod: 	grab_cache_page_nowait
depmod: 	strsep
depmod: 	init_special_inode
depmod: 	kmem_cache_free
depmod: 	load_nls
depmod: 	page_address
depmod: 	unlock_page
depmod: 	unlock_new_inode
depmod: 	kmalloc
depmod: 	generic_read_dir
depmod: 	_ctype
depmod: 	__wait_on_buffer
depmod: 	__up_wakeup
depmod: 	load_nls_default
depmod: 	kernel_flag
depmod: 	__bread
depmod: 	__get_free_pages
depmod: 	vfree
depmod: 	utf8_wctomb
depmod: 	__page_cache_release
depmod: 	unregister_filesystem
depmod: 	iput
depmod: 	block_read_full_page
depmod: 	kunmap
depmod: 	d_rehash
depmod: 	make_bad_inode
depmod: 	panic
depmod: 	inode_init_once
depmod: 	ll_rw_block
depmod: 	iget_locked
depmod: 	register_filesystem
depmod: 	free_pages
depmod: 	block_sync_page
depmod: 	__getblk
depmod: 	kmem_cache_create
depmod: 	unload_nls
depmod: 	d_alloc_root
depmod: 	page_symlink_inode_operations
depmod: 	__read_lock_failed
depmod: 	kfree
depmod: 	kill_block_super
depmod: 	vmalloc
depmod: 	sb_set_blocksize
depmod: 	contig_page_data
depmod: 	generic_ro_fops
depmod: 	simple_strtoul
depmod: 	ioctl_by_bdev
depmod: 	sprintf
depmod: 	kmem_cache_destroy
depmod: 	__brelse
depmod: 	d_instantiate
depmod: 	get_sb_bdev
depmod: 	__free_pages
depmod: 	printk
depmod: 	dparent_lock
depmod: 	kmem_cache_alloc
depmod: 	strnicmp
depmod: 	kmap
depmod: 	__down_failed
depmod: 	generic_block_bmap
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/fs/jfs/jfs.ko
depmod: 	__down_failed_trylock
depmod: 	mpage_writepages
depmod: 	schedule_timeout
depmod: 	strsep
depmod: 	__wake_up
depmod: 	init_special_inode
depmod: 	generic_file_llseek
depmod: 	filemap_fdatawrite
depmod: 	kmem_cache_free
depmod: 	load_nls
depmod: 	schedule
depmod: 	simple_strtoull
depmod: 	block_prepare_write
depmod: 	generic_file_write
depmod: 	unlock_page
depmod: 	generic_commit_write
depmod: 	clear_inode
depmod: 	unlock_new_inode
depmod: 	kmalloc
depmod: 	new_inode
depmod: 	generic_read_dir
depmod: 	find_lock_page
depmod: 	__wait_on_buffer
depmod: 	submit_bio
depmod: 	__up_wakeup
depmod: 	bd_release
depmod: 	add_wait_queue_exclusive
depmod: 	mpage_readpage
depmod: 	load_nls_default
depmod: 	kernel_flag
depmod: 	__bread
depmod: 	__get_free_pages
depmod: 	vfree
depmod: 	blkdev_put
depmod: 	default_wake_function
depmod: 	__mark_inode_dirty
depmod: 	__page_cache_release
depmod: 	current_kernel_time
depmod: 	unregister_filesystem
depmod: 	vfs_readlink
depmod: 	iput
depmod: 	permission
depmod: 	mempool_free
depmod: 	complete
depmod: 	remove_wait_queue
depmod: 	kunmap
depmod: 	__cond_resched
depmod: 	generic_file_mmap
depmod: 	is_bad_inode
depmod: 	d_rehash
depmod: 	make_bad_inode
depmod: 	inode_init_once
depmod: 	ll_rw_block
depmod: 	bio_put
depmod: 	mempool_alloc
depmod: 	bdget
depmod: 	generic_file_read
depmod: 	iget_locked
depmod: 	generic_file_open
depmod: 	__lock_page
depmod: 	block_invalidatepage
depmod: 	register_filesystem
depmod: 	free_pages
depmod: 	block_sync_page
depmod: 	generic_direct_IO
depmod: 	kmem_cache_create
depmod: 	bio_alloc
depmod: 	unload_nls
depmod: 	d_alloc_root
depmod: 	page_symlink_inode_operations
depmod: 	blk_run_queues
depmod: 	mark_buffer_dirty
depmod: 	kfree
depmod: 	generic_file_sendfile
depmod: 	kill_block_super
depmod: 	blkdev_get
depmod: 	d_alloc_anon
depmod: 	vmalloc
depmod: 	wait_for_completion
depmod: 	rwsem_down_write_failed
depmod: 	rwsem_wake
depmod: 	mpage_readpages
depmod: 	generic_file_readv
depmod: 	__bforget
depmod: 	sb_set_blocksize
depmod: 	filemap_fdatawait
depmod: 	find_or_create_page
depmod: 	add_wait_queue
depmod: 	vfs_follow_link
depmod: 	block_truncate_page
depmod: 	d_splice_alias
depmod: 	mem_map
depmod: 	sync_blockdev
depmod: 	kmem_cache_destroy
depmod: 	__brelse
depmod: 	read_cache_page
depmod: 	daemonize
depmod: 	generic_file_writev
depmod: 	d_instantiate
depmod: 	write_one_page
depmod: 	block_write_full_page
depmod: 	get_sb_bdev
depmod: 	mempool_destroy
depmod: 	truncate_inode_pages
depmod: 	printk
depmod: 	kernel_thread
depmod: 	kmem_cache_alloc
depmod: 	rwsem_down_read_failed
depmod: 	__insert_inode_hash
depmod: 	bd_claim
depmod: 	kmap
depmod: 	recalc_sigpending
depmod: 	mempool_create
depmod: 	__down_failed
depmod: 	generic_block_bmap
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/fs/lockd/lockd=
.ko
depmod: 	file_lock_list
depmod: 	flush_signals
depmod: 	schedule_timeout
depmod: 	__wake_up
depmod: 	posix_block_lock
depmod: 	posix_test_lock
depmod: 	snprintf
depmod: 	kmalloc
depmod: 	__up_wakeup
depmod: 	kernel_flag
depmod: 	posix_unblock_lock
depmod: 	locks_init_lock
depmod: 	posix_locks_deadlock
depmod: 	kill_proc
depmod: 	interruptible_sleep_on_timeout
depmod: 	system_utsname
depmod: 	interruptible_sleep_on
depmod: 	kfree
depmod: 	locks_copy_lock
depmod: 	sleep_on_timeout
depmod: 	sprintf
depmod: 	daemonize
depmod: 	jiffies
depmod: 	printk
depmod: 	kernel_thread
depmod: 	posix_lock_file
depmod: 	recalc_sigpending
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/fs/msdos/msdos=
.ko
depmod: 	kernel_flag
depmod: 	__mark_inode_dirty
depmod: 	current_kernel_time
depmod: 	unregister_filesystem
depmod: 	iput
depmod: 	register_filesystem
depmod: 	mark_buffer_dirty
depmod: 	kill_block_super
depmod: 	d_splice_alias
depmod: 	__brelse
depmod: 	d_instantiate
depmod: 	get_sb_bdev
depmod: 	printk
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/fs/nfs/nfs.ko
depmod: 	__alloc_pages
depmod: 	dput
depmod: 	mempool_free_slab
depmod: 	sget
depmod: 	do_sync_read
depmod: 	mpage_writepages
depmod: 	have_submounts
depmod: 	d_alloc
depmod: 	schedule_timeout
depmod: 	yield
depmod: 	d_delete
depmod: 	radix_tree_lookup
depmod: 	mempool_alloc_slab
depmod: 	__wake_up
depmod: 	__per_cpu_offset
depmod: 	init_special_inode
depmod: 	filemap_fdatawrite
depmod: 	kmem_cache_free
depmod: 	schedule
depmod: 	unlock_page
depmod: 	clear_inode
depmod: 	unlock_new_inode
depmod: 	snprintf
depmod: 	kmalloc
depmod: 	page_states__per_cpu
depmod: 	generic_read_dir
depmod: 	generic_file_aio_read
depmod: 	__up_wakeup
depmod: 	seq_escape
depmod: 	find_get_page
depmod: 	kill_anon_super
depmod: 	kernel_flag
depmod: 	default_wake_function
depmod: 	__mark_inode_dirty
depmod: 	__page_cache_release
depmod: 	unregister_filesystem
depmod: 	vfs_readlink
depmod: 	iput
depmod: 	mempool_free
depmod: 	dcache_lock
depmod: 	remove_wait_queue
depmod: 	kunmap
depmod: 	generic_file_mmap
depmod: 	is_bad_inode
depmod: 	d_rehash
depmod: 	make_bad_inode
depmod: 	inode_init_once
depmod: 	mempool_alloc
depmod: 	d_move
depmod: 	generic_fillattr
depmod: 	register_filesystem
depmod: 	remove_inode_hash
depmod: 	invalidate_inode_pages
depmod: 	kmem_cache_create
depmod: 	radix_tree_delete
depmod: 	__set_page_dirty_nobuffers
depmod: 	d_alloc_root
depmod: 	read_cache_pages
depmod: 	__read_lock_failed
depmod: 	kunmap_atomic
depmod: 	generic_file_aio_write
depmod: 	deactivate_super
depmod: 	kfree
depmod: 	lookup_one_len
depmod: 	radix_tree_insert
depmod: 	rwsem_wake
depmod: 	radix_tree_gang_lookup
depmod: 	do_sync_write
depmod: 	vfs_permission
depmod: 	filemap_fdatawait
depmod: 	add_wait_queue
depmod: 	remote_llseek
depmod: 	vfs_follow_link
depmod: 	seq_printf
depmod: 	fput
depmod: 	vmtruncate
depmod: 	contig_page_data
depmod: 	igrab
depmod: 	set_anon_super
depmod: 	shrink_dcache_parent
depmod: 	sprintf
depmod: 	kmem_cache_destroy
depmod: 	read_cache_page
depmod: 	jiffies
depmod: 	d_instantiate
depmod: 	mempool_destroy
depmod: 	printk
depmod: 	kmap_atomic
depmod: 	dparent_lock
depmod: 	kmem_cache_alloc
depmod: 	iget5_locked
depmod: 	kmap
depmod: 	end_page_writeback
depmod: 	mempool_create
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/fs/nfsd/nfsd.k=
o
depmod: 	send_sig
depmod: 	dput
depmod: 	seq_lseek
depmod: 	d_path
depmod: 	d_alloc
depmod: 	schedule_timeout
depmod: 	vfs_link
depmod: 	filemap_fdatawrite
depmod: 	path_release
depmod: 	page_address
depmod: 	vfs_mknod
depmod: 	__write_lock_failed
depmod: 	update_atime
depmod: 	vfs_symlink
depmod: 	vfs_statfs
depmod: 	snprintf
depmod: 	kmalloc
depmod: 	new_inode
depmod: 	seq_release
depmod: 	seq_open
depmod: 	__up_wakeup
depmod: 	seq_escape
depmod: 	create_proc_entry
depmod: 	vfs_unlink
depmod: 	kernel_flag
depmod: 	__get_free_pages
depmod: 	simple_strtol
depmod: 	current_kernel_time
depmod: 	unregister_filesystem
depmod: 	lease_get_mtime
depmod: 	iput
depmod: 	permission
depmod: 	__mntput
depmod: 	vfs_create
depmod: 	d_rehash
depmod: 	__break_lease
depmod: 	copy_to_user
depmod: 	init_private_file
depmod: 	vfs_mkdir
depmod: 	register_filesystem
depmod: 	free_pages
depmod: 	get_sb_single
depmod: 	locks_mandatory_area
depmod: 	proc_mkdir
depmod: 	do_gettimeofday
depmod: 	vfs_readv
depmod: 	d_alloc_root
depmod: 	vfs_rename
depmod: 	__read_lock_failed
depmod: 	d_genocide
depmod: 	simple_statfs
depmod: 	kfree
depmod: 	lock_may_read
depmod: 	lock_may_write
depmod: 	follow_up
depmod: 	path_lookup
depmod: 	lookup_one_len
depmod: 	vfs_getattr
depmod: 	remove_proc_entry
depmod: 	rwsem_down_write_failed
depmod: 	vfs_rmdir
depmod: 	rwsem_wake
depmod: 	kill_litter_super
depmod: 	simple_dir_inode_operations
depmod: 	seq_read
depmod: 	filemap_fdatawait
depmod: 	seq_printf
depmod: 	xtime
depmod: 	unlock_rename
depmod: 	simple_strtoul
depmod: 	sprintf
depmod: 	copy_from_user
depmod: 	daemonize
depmod: 	jiffies
depmod: 	d_instantiate
depmod: 	inode_change_ok
depmod: 	get_write_access
depmod: 	notify_change
depmod: 	printk
depmod: 	dparent_lock
depmod: 	write_inode_now
depmod: 	simple_dir_operations
depmod: 	vfs_readdir
depmod: 	rwsem_down_read_failed
depmod: 	lock_rename
depmod: 	follow_down
depmod: 	vfs_writev
depmod: 	recalc_sigpending
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/fs/ntfs/ntfs.k=
o
depmod: 	grab_cache_page_nowait
depmod: 	d_alloc
depmod: 	strsep
depmod: 	vsnprintf
depmod: 	generic_file_llseek
depmod: 	kmem_cache_free
depmod: 	load_nls
depmod: 	page_address
depmod: 	schedule
depmod: 	unlock_buffer
depmod: 	unlock_page
depmod: 	unlock_new_inode
depmod: 	kmalloc
depmod: 	generic_read_dir
depmod: 	__wait_on_buffer
depmod: 	__up_wakeup
depmod: 	load_nls_default
depmod: 	__bread
depmod: 	vfree
depmod: 	__page_cache_release
depmod: 	unregister_filesystem
depmod: 	wait_on_page_bit
depmod: 	iput
depmod: 	high_memory
depmod: 	kunmap
depmod: 	generic_file_mmap
depmod: 	is_bad_inode
depmod: 	d_rehash
depmod: 	make_bad_inode
depmod: 	panic
depmod: 	inode_init_once
depmod: 	ll_rw_block
depmod: 	generic_file_read
depmod: 	iget_locked
depmod: 	generic_file_open
depmod: 	create_empty_buffers
depmod: 	submit_bh
depmod: 	register_filesystem
depmod: 	block_sync_page
depmod: 	__getblk
depmod: 	kmem_cache_create
depmod: 	unload_nls
depmod: 	d_alloc_root
depmod: 	__read_lock_failed
depmod: 	kunmap_atomic
depmod: 	blk_run_queues
depmod: 	__PAGE_KERNEL
depmod: 	mark_buffer_dirty
depmod: 	d_lookup
depmod: 	kfree
depmod: 	generic_file_sendfile
depmod: 	kill_block_super
depmod: 	vmalloc
depmod: 	rwsem_down_write_failed
depmod: 	rwsem_wake
depmod: 	sb_set_blocksize
depmod: 	invalidate_inodes
depmod: 	seq_printf
depmod: 	xtime
depmod: 	igrab
depmod: 	simple_strtoul
depmod: 	kmem_cache_destroy
depmod: 	__brelse
depmod: 	read_cache_page
depmod: 	d_instantiate
depmod: 	num_physpages
depmod: 	__vmalloc
depmod: 	get_sb_bdev
depmod: 	printk
depmod: 	kmap_atomic
depmod: 	dparent_lock
depmod: 	kmem_cache_alloc
depmod: 	rwsem_down_read_failed
depmod: 	iget5_locked
depmod: 	kmap
depmod: 	end_buffer_io_sync
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/fs/reiserfs/re=
iserfs.ko
depmod: 	create_workqueue
depmod: 	inode_setattr
depmod: 	dput
depmod: 	mark_buffer_async_write
depmod: 	yield
depmod: 	buffer_insert_list
depmod: 	filp_open
depmod: 	strsep
depmod: 	__wake_up
depmod: 	__per_cpu_offset
depmod: 	init_special_inode
depmod: 	kmem_cache_free
depmod: 	page_address
depmod: 	schedule
depmod: 	unlock_buffer
depmod: 	update_atime
depmod: 	block_prepare_write
depmod: 	generic_file_write
depmod: 	vsprintf
depmod: 	unlock_page
depmod: 	generic_commit_write
depmod: 	clear_inode
depmod: 	unlock_new_inode
depmod: 	kmalloc
depmod: 	page_states__per_cpu
depmod: 	new_inode
depmod: 	generic_read_dir
depmod: 	kdevname
depmod: 	__wait_on_buffer
depmod: 	__up_wakeup
depmod: 	kernel_flag
depmod: 	__bread
depmod: 	vfree
depmod: 	blkdev_put
depmod: 	default_wake_function
depmod: 	__mark_inode_dirty
depmod: 	__page_cache_release
depmod: 	__bdevname
depmod: 	current_kernel_time
depmod: 	unregister_filesystem
depmod: 	iput
depmod: 	sleep_on
depmod: 	block_read_full_page
depmod: 	remove_wait_queue
depmod: 	kunmap
depmod: 	__cond_resched
depmod: 	generic_file_mmap
depmod: 	is_bad_inode
depmod: 	d_rehash
depmod: 	make_bad_inode
depmod: 	panic
depmod: 	inode_init_once
depmod: 	ll_rw_block
depmod: 	destroy_workqueue
depmod: 	bdget
depmod: 	generic_file_read
depmod: 	submit_bh
depmod: 	register_filesystem
depmod: 	block_sync_page
depmod: 	filp_close
depmod: 	__getblk
depmod: 	kmem_cache_create
depmod: 	d_alloc_root
depmod: 	page_symlink_inode_operations
depmod: 	__read_lock_failed
depmod: 	sync_mapping_buffers
depmod: 	kunmap_atomic
depmod: 	mark_buffer_dirty
depmod: 	kfree
depmod: 	generic_file_sendfile
depmod: 	flush_workqueue
depmod: 	kill_block_super
depmod: 	blkdev_get
depmod: 	fsync_buffers_list
depmod: 	d_alloc_anon
depmod: 	try_to_free_buffers
depmod: 	vmalloc
depmod: 	generic_cont_expand
depmod: 	__bforget
depmod: 	sb_set_blocksize
depmod: 	generate_random_uuid
depmod: 	find_or_create_page
depmod: 	add_wait_queue
depmod: 	set_blocksize
depmod: 	d_splice_alias
depmod: 	xtime
depmod: 	queue_work
depmod: 	simple_strtoul
depmod: 	sprintf
depmod: 	kmem_cache_destroy
depmod: 	__brelse
depmod: 	bdev_read_only
depmod: 	__find_get_block
depmod: 	d_instantiate
depmod: 	get_sb_bdev
depmod: 	inode_change_ok
depmod: 	printk
depmod: 	kmap_atomic
depmod: 	dparent_lock
depmod: 	kmem_cache_alloc
depmod: 	iget5_locked
depmod: 	__insert_inode_hash
depmod: 	kmap
depmod: 	end_page_writeback
depmod: 	__down_failed
depmod: 	generic_block_bmap
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/fs/romfs/romfs=
.ko
depmod: 	init_special_inode
depmod: 	kmem_cache_free
depmod: 	unlock_page
depmod: 	unlock_new_inode
depmod: 	generic_read_dir
depmod: 	kernel_flag
depmod: 	__bread
depmod: 	__page_cache_release
depmod: 	unregister_filesystem
depmod: 	kunmap
depmod: 	d_rehash
depmod: 	inode_init_once
depmod: 	iget_locked
depmod: 	register_filesystem
depmod: 	kmem_cache_create
depmod: 	d_alloc_root
depmod: 	page_symlink_inode_operations
depmod: 	kill_block_super
depmod: 	sb_set_blocksize
depmod: 	generic_ro_fops
depmod: 	kmem_cache_destroy
depmod: 	__brelse
depmod: 	d_instantiate
depmod: 	get_sb_bdev
depmod: 	printk
depmod: 	kmem_cache_alloc
depmod: 	kmap
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/fs/smbfs/smbfs=
.ko
depmod: 	d_validate
depmod: 	dput
depmod: 	wait_on_sync_kiocb
depmod: 	generic_delete_inode
depmod: 	d_alloc
depmod: 	schedule_timeout
depmod: 	d_delete
depmod: 	strsep
depmod: 	put_cmsg
depmod: 	__wake_up
depmod: 	init_special_inode
depmod: 	filemap_fdatawrite
depmod: 	kmem_cache_free
depmod: 	load_nls
depmod: 	schedule
depmod: 	generic_file_write
depmod: 	unlock_page
depmod: 	clear_inode
depmod: 	kmalloc
depmod: 	new_inode
depmod: 	generic_read_dir
depmod: 	find_lock_page
depmod: 	__down_failed_interruptible
depmod: 	_ctype
depmod: 	__up_wakeup
depmod: 	kill_anon_super
depmod: 	kernel_flag
depmod: 	scm_detach_fds
depmod: 	default_wake_function
depmod: 	__page_cache_release
depmod: 	current_kernel_time
depmod: 	unregister_filesystem
depmod: 	vfs_readlink
depmod: 	iput
depmod: 	dcache_lock
depmod: 	remove_wait_queue
depmod: 	find_inode_number
depmod: 	dget_locked
depmod: 	kunmap
depmod: 	kill_proc
depmod: 	generic_file_mmap
depmod: 	is_bad_inode
depmod: 	d_rehash
depmod: 	make_bad_inode
depmod: 	inode_init_once
depmod: 	generic_file_read
depmod: 	generic_fillattr
depmod: 	register_filesystem
depmod: 	invalidate_inode_pages
depmod: 	kmem_cache_create
depmod: 	unload_nls
depmod: 	d_alloc_root
depmod: 	__read_lock_failed
depmod: 	get_sb_nodev
depmod: 	d_lookup
depmod: 	kfree
depmod: 	shrink_dcache_sb
depmod: 	invalidate_inodes
depmod: 	iunique
depmod: 	filemap_fdatawait
depmod: 	find_or_create_page
depmod: 	add_wait_queue
depmod: 	remote_llseek
depmod: 	vfs_follow_link
depmod: 	seq_printf
depmod: 	fput
depmod: 	vmtruncate
depmod: 	__scm_destroy
depmod: 	xtime
depmod: 	simple_strtoul
depmod: 	sprintf
depmod: 	kmem_cache_destroy
depmod: 	copy_from_user
depmod: 	daemonize
depmod: 	fget
depmod: 	jiffies
depmod: 	d_instantiate
depmod: 	inode_change_ok
depmod: 	printk
depmod: 	kernel_thread
depmod: 	dparent_lock
depmod: 	kmem_cache_alloc
depmod: 	__insert_inode_hash
depmod: 	kmap
depmod: 	recalc_sigpending
depmod: 	__down_failed
depmod: 	__scm_send
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/fs/udf/udf.ko
depmod: 	sb_min_blocksize
depmod: 	__get_user_4
depmod: 	strsep
depmod: 	init_special_inode
depmod: 	kmem_cache_free
depmod: 	load_nls
depmod: 	page_address
depmod: 	unlock_buffer
depmod: 	update_atime
depmod: 	block_prepare_write
depmod: 	generic_file_write
depmod: 	vsprintf
depmod: 	unlock_page
depmod: 	generic_commit_write
depmod: 	clear_inode
depmod: 	unlock_new_inode
depmod: 	kmalloc
depmod: 	new_inode
depmod: 	generic_read_dir
depmod: 	__wait_on_buffer
depmod: 	__up_wakeup
depmod: 	load_nls_default
depmod: 	kernel_flag
depmod: 	__bread
depmod: 	__mark_inode_dirty
depmod: 	__page_cache_release
depmod: 	current_kernel_time
depmod: 	unregister_filesystem
depmod: 	iput
depmod: 	permission
depmod: 	block_read_full_page
depmod: 	kunmap
depmod: 	generic_file_mmap
depmod: 	is_bad_inode
depmod: 	d_rehash
depmod: 	make_bad_inode
depmod: 	inode_init_once
depmod: 	ll_rw_block
depmod: 	copy_to_user
depmod: 	generic_file_read
depmod: 	iget_locked
depmod: 	register_filesystem
depmod: 	block_sync_page
depmod: 	__getblk
depmod: 	kmem_cache_create
depmod: 	unload_nls
depmod: 	d_alloc_root
depmod: 	page_symlink_inode_operations
depmod: 	sys_tz
depmod: 	__read_lock_failed
depmod: 	sync_mapping_buffers
depmod: 	mark_buffer_dirty
depmod: 	kfree
depmod: 	generic_file_sendfile
depmod: 	kill_block_super
depmod: 	find_or_create_page
depmod: 	block_truncate_page
depmod: 	simple_strtoul
depmod: 	ioctl_by_bdev
depmod: 	kmem_cache_destroy
depmod: 	__brelse
depmod: 	d_instantiate
depmod: 	block_write_full_page
depmod: 	get_sb_bdev
depmod: 	printk
depmod: 	dparent_lock
depmod: 	mark_buffer_dirty_inode
depmod: 	kmem_cache_alloc
depmod: 	__insert_inode_hash
depmod: 	kmap
depmod: 	__down_failed
depmod: 	generic_block_bmap
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/fs/vfat/vfat.k=
o
depmod: 	dput
depmod: 	d_invalidate
depmod: 	kmalloc
depmod: 	_ctype
depmod: 	kernel_flag
depmod: 	__get_free_pages
depmod: 	__mark_inode_dirty
depmod: 	current_kernel_time
depmod: 	unregister_filesystem
depmod: 	iput
depmod: 	dcache_lock
depmod: 	d_find_alias
depmod: 	register_filesystem
depmod: 	free_pages
depmod: 	mark_buffer_dirty
depmod: 	kfree
depmod: 	kill_block_super
depmod: 	utf8_mbstowcs
depmod: 	d_splice_alias
depmod: 	sprintf
depmod: 	__brelse
depmod: 	jiffies
depmod: 	d_instantiate
depmod: 	get_sb_bdev
depmod: 	printk
depmod: 	strnicmp
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/net/ipv4/ip_gr=
e.ko
depmod: 	ip_send_check
depmod: 	register_netdevice
depmod: 	__ip_select_ident
depmod: 	sock_wfree
depmod: 	icmp_send
depmod: 	__kfree_skb
depmod: 	__pskb_pull_tail
depmod: 	__write_lock_failed
depmod: 	skb_under_panic
depmod: 	kmalloc
depmod: 	skb_realloc_headroom
depmod: 	unregister_netdevice
depmod: 	ip_route_output_key
depmod: 	netdev_finish_unregister
depmod: 	netdev_state_change
depmod: 	skb_checksum
depmod: 	unregister_netdev
depmod: 	copy_to_user
depmod: 	inet_del_protocol
depmod: 	inet_add_protocol
depmod: 	__read_lock_failed
depmod: 	register_netdev
depmod: 	kfree
depmod: 	__dev_get_by_index
depmod: 	netif_rx
depmod: 	csum_partial
depmod: 	sprintf
depmod: 	copy_from_user
depmod: 	sysctl_ip_default_ttl
depmod: 	jiffies
depmod: 	printk
depmod: 	irq_stat
depmod: 	do_softirq
depmod: 	nf_hook_slow
depmod: 	__dev_get_by_name
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/net/ipv4/ipip.=
ko
depmod: 	ip_send_check
depmod: 	register_netdevice
depmod: 	__ip_select_ident
depmod: 	sock_wfree
depmod: 	icmp_send
depmod: 	__kfree_skb
depmod: 	__pskb_pull_tail
depmod: 	__write_lock_failed
depmod: 	skb_under_panic
depmod: 	kmalloc
depmod: 	skb_realloc_headroom
depmod: 	unregister_netdevice
depmod: 	ip_route_output_key
depmod: 	netdev_finish_unregister
depmod: 	netdev_state_change
depmod: 	unregister_netdev
depmod: 	copy_to_user
depmod: 	inet_del_protocol
depmod: 	inet_add_protocol
depmod: 	__read_lock_failed
depmod: 	register_netdev
depmod: 	kfree
depmod: 	__dev_get_by_index
depmod: 	netif_rx
depmod: 	sprintf
depmod: 	copy_from_user
depmod: 	jiffies
depmod: 	printk
depmod: 	irq_stat
depmod: 	do_softirq
depmod: 	nf_hook_slow
depmod: 	__dev_get_by_name
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/net/ipv4/netfi=
lter/arp_tables.ko
depmod: 	__down_failed_trylock
depmod: 	__write_lock_failed
depmod: 	__down_failed_interruptible
depmod: 	__up_wakeup
depmod: 	create_proc_entry
depmod: 	vfree
depmod: 	nf_unregister_sockopt
depmod: 	copy_to_user
depmod: 	request_module
depmod: 	__read_lock_failed
depmod: 	net_ratelimit
depmod: 	vmalloc
depmod: 	remove_proc_entry
depmod: 	proc_net
depmod: 	nf_register_sockopt
depmod: 	sprintf
depmod: 	copy_from_user
depmod: 	num_physpages
depmod: 	printk
depmod: 	irq_stat
depmod: 	do_softirq
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/net/ipv4/netfi=
lter/arptable_filter.ko
depmod: 	nf_unregister_hook
depmod: 	nf_register_hook
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/net/ipv4/netfi=
lter/ip_conntrack.ko
depmod: 	ip_send_check
depmod: 	nf_unregister_hook
depmod: 	sock_wfree
depmod: 	__kfree_skb
depmod: 	kmem_cache_free
depmod: 	__br_write_lock
depmod: 	schedule
depmod: 	__write_lock_failed
depmod: 	kmalloc
depmod: 	skb_linearize
depmod: 	ip_defrag
depmod: 	create_proc_entry
depmod: 	vfree
depmod: 	__br_write_unlock
depmod: 	nf_unregister_sockopt
depmod: 	copy_to_user
depmod: 	kmem_cache_create
depmod: 	ip_ct_attach
depmod: 	proc_dointvec
depmod: 	__read_lock_failed
depmod: 	unregister_sysctl_table
depmod: 	del_timer
depmod: 	net_ratelimit
depmod: 	ip_fragment
depmod: 	sk_free
depmod: 	kfree
depmod: 	vmalloc
depmod: 	remove_proc_entry
depmod: 	nf_register_hook
depmod: 	csum_partial
depmod: 	proc_net
depmod: 	nf_register_sockopt
depmod: 	sprintf
depmod: 	kmem_cache_destroy
depmod: 	jiffies
depmod: 	num_physpages
depmod: 	printk
depmod: 	add_timer
depmod: 	irq_stat
depmod: 	register_sysctl_table
depmod: 	kmem_cache_alloc
depmod: 	do_softirq
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/net/ipv4/netfi=
lter/ip_conntrack_ftp.ko
depmod: 	_ctype
depmod: 	net_ratelimit
depmod: 	csum_partial
depmod: 	sprintf
depmod: 	printk
depmod: 	irq_stat
depmod: 	strnicmp
depmod: 	do_softirq
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/net/ipv4/netfi=
lter/ip_conntrack_irc.ko
depmod: 	net_ratelimit
depmod: 	csum_partial
depmod: 	simple_strtoul
depmod: 	sprintf
depmod: 	printk
depmod: 	irq_stat
depmod: 	do_softirq
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/net/ipv4/netfi=
lter/ip_nat_ftp.ko
depmod: 	net_ratelimit
depmod: 	sprintf
depmod: 	printk
depmod: 	irq_stat
depmod: 	do_softirq
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/net/ipv4/netfi=
lter/ip_nat_irc.ko
depmod: 	net_ratelimit
depmod: 	sprintf
depmod: 	printk
depmod: 	irq_stat
depmod: 	do_softirq
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/net/ipv4/netfi=
lter/ip_tables.ko
depmod: 	__down_failed_trylock
depmod: 	__write_lock_failed
depmod: 	__down_failed_interruptible
depmod: 	__up_wakeup
depmod: 	create_proc_entry
depmod: 	vfree
depmod: 	nf_unregister_sockopt
depmod: 	copy_to_user
depmod: 	request_module
depmod: 	__read_lock_failed
depmod: 	net_ratelimit
depmod: 	vmalloc
depmod: 	remove_proc_entry
depmod: 	proc_net
depmod: 	nf_register_sockopt
depmod: 	sprintf
depmod: 	copy_from_user
depmod: 	num_physpages
depmod: 	printk
depmod: 	irq_stat
depmod: 	do_softirq
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/net/ipv4/netfi=
lter/ipt_LOG.ko
depmod: 	printk
depmod: 	irq_stat
depmod: 	do_softirq
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/net/ipv4/netfi=
lter/ipt_MASQUERADE.ko
depmod: 	__write_lock_failed
depmod: 	unregister_netdevice_notifier
depmod: 	unregister_inetaddr_notifier
depmod: 	ip_route_output_key
depmod: 	register_inetaddr_notifier
depmod: 	__read_lock_failed
depmod: 	register_netdevice_notifier
depmod: 	printk
depmod: 	irq_stat
depmod: 	do_softirq
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/net/ipv4/netfi=
lter/ipt_REJECT.ko
depmod: 	__ip_select_ident
depmod: 	__kfree_skb
depmod: 	alloc_skb
depmod: 	ip_finish_output
depmod: 	ip_route_output_key
depmod: 	skb_copy
depmod: 	ip_ct_attach
depmod: 	___pskb_trim
depmod: 	xrlim_allow
depmod: 	csum_partial
depmod: 	skb_over_panic
depmod: 	printk
depmod: 	nf_hook_slow
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/net/ipv4/netfi=
lter/ipt_TCPMSS.ko
depmod: 	__kfree_skb
depmod: 	skb_copy
depmod: 	net_ratelimit
depmod: 	csum_partial
depmod: 	skb_over_panic
depmod: 	printk
depmod: 	skb_copy_expand
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/net/ipv4/netfi=
lter/ipt_ULOG.ko
depmod: 	__kfree_skb
depmod: 	alloc_skb
depmod: 	netlink_kernel_create
depmod: 	netlink_broadcast
depmod: 	del_timer
depmod: 	net_ratelimit
depmod: 	skb_over_panic
depmod: 	sock_release
depmod: 	jiffies
depmod: 	printk
depmod: 	add_timer
depmod: 	irq_stat
depmod: 	do_softirq
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/net/ipv4/netfi=
lter/ipt_conntrack.ko
depmod: 	jiffies
depmod: 	printk
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/net/ipv4/netfi=
lter/ipt_ecn.ko
depmod: 	printk
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/net/ipv4/netfi=
lter/ipt_helper.ko
depmod: 	printk
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/net/ipv4/netfi=
lter/ipt_limit.ko
depmod: 	jiffies
depmod: 	printk
depmod: 	irq_stat
depmod: 	do_softirq
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/net/ipv4/netfi=
lter/ipt_mac.ko
depmod: 	printk
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/net/ipv4/netfi=
lter/ipt_state.ko
depmod: 	printk
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/net/ipv4/netfi=
lter/ipt_tcpmss.ko
depmod: 	printk
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/net/ipv4/netfi=
lter/ipt_ttl.ko
depmod: 	printk
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/net/ipv4/netfi=
lter/iptable_filter.ko
depmod: 	nf_unregister_hook
depmod: 	net_ratelimit
depmod: 	nf_register_hook
depmod: 	printk
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/net/ipv4/netfi=
lter/iptable_nat.ko
depmod: 	ip_send_check
depmod: 	nf_unregister_hook
depmod: 	sock_wfree
depmod: 	__kfree_skb
depmod: 	ip_route_me_harder
depmod: 	__br_write_lock
depmod: 	__write_lock_failed
depmod: 	vfree
depmod: 	__br_write_unlock
depmod: 	skb_copy
depmod: 	request_module
depmod: 	__read_lock_failed
depmod: 	net_ratelimit
depmod: 	___pskb_trim
depmod: 	vmalloc
depmod: 	nf_register_hook
depmod: 	csum_partial
depmod: 	skb_over_panic
depmod: 	sprintf
depmod: 	printk
depmod: 	irq_stat
depmod: 	do_softirq
depmod: 	skb_copy_expand
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/net/sunrpc/sun=
rpc.ko
depmod: 	sock_alloc
depmod: 	__alloc_pages
depmod: 	mempool_free_slab
depmod: 	skb_free_datagram
depmod: 	flush_signals
depmod: 	schedule_timeout
depmod: 	yield
depmod: 	del_timer_sync
depmod: 	mempool_alloc_slab
depmod: 	__wake_up
depmod: 	sock_sendmsg
depmod: 	page_address
depmod: 	schedule
depmod: 	__write_lock_failed
depmod: 	tcp_read_sock
depmod: 	snprintf
depmod: 	kmalloc
depmod: 	_ctype
depmod: 	__up_wakeup
depmod: 	create_proc_entry
depmod: 	kernel_flag
depmod: 	simple_strtol
depmod: 	default_wake_function
depmod: 	__page_cache_release
depmod: 	no_llseek
depmod: 	__lock_sock
depmod: 	skb_checksum
depmod: 	mempool_free
depmod: 	remove_wait_queue
depmod: 	skb_recv_datagram
depmod: 	kunmap
depmod: 	__cond_resched
depmod: 	net_random
depmod: 	kill_proc
depmod: 	copy_to_user
depmod: 	mempool_alloc
depmod: 	__release_sock
depmod: 	system_utsname
depmod: 	proc_mkdir
depmod: 	kmem_cache_create
depmod: 	__read_lock_failed
depmod: 	unregister_sysctl_table
depmod: 	atomic_dec_and_lock
depmod: 	net_ratelimit
depmod: 	kunmap_atomic
depmod: 	mod_timer
depmod: 	interruptible_sleep_on
depmod: 	kfree
depmod: 	remove_proc_entry
depmod: 	sock_recvmsg
depmod: 	csum_partial
depmod: 	add_wait_queue
depmod: 	xtime
depmod: 	sock_release
depmod: 	contig_page_data
depmod: 	sleep_on_timeout
depmod: 	sscanf
depmod: 	sock_create
depmod: 	sprintf
depmod: 	kmem_cache_destroy
depmod: 	copy_from_user
depmod: 	skb_copy_and_csum_bits
depmod: 	daemonize
depmod: 	skb_copy_bits
depmod: 	jiffies
depmod: 	mempool_destroy
depmod: 	printk
depmod: 	irq_stat
depmod: 	kmap_atomic
depmod: 	kernel_thread
depmod: 	register_sysctl_table
depmod: 	do_softirq
depmod: 	kmap
depmod: 	recalc_sigpending
depmod: 	mempool_create
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/net/unix/unix.=
ko
depmod: 	send_sig
depmod: 	dput
depmod: 	sock_wfree
depmod: 	__down_failed_trylock
depmod: 	skb_free_datagram
depmod: 	schedule_timeout
depmod: 	yield
depmod: 	__wake_up
depmod: 	__kfree_skb
depmod: 	lookup_hash
depmod: 	path_release
depmod: 	vfs_mknod
depmod: 	__write_lock_failed
depmod: 	update_atime
depmod: 	sock_no_getsockopt
depmod: 	kmalloc
depmod: 	sock_wmalloc
depmod: 	__up_wakeup
depmod: 	files_stat
depmod: 	create_proc_entry
depmod: 	add_wait_queue_exclusive
depmod: 	sock_unregister
depmod: 	default_wake_function
depmod: 	permission
depmod: 	memcpy_toiovec
depmod: 	remove_wait_queue
depmod: 	sk_alloc
depmod: 	skb_recv_datagram
depmod: 	__mntput
depmod: 	sock_wake_async
depmod: 	scm_fp_dup
depmod: 	sock_no_setsockopt
depmod: 	sock_no_accept
depmod: 	kmem_cache_create
depmod: 	proc_dointvec
depmod: 	__read_lock_failed
depmod: 	unregister_sysctl_table
depmod: 	skb_copy_datagram_iovec
depmod: 	sk_free
depmod: 	datagram_poll
depmod: 	kfree
depmod: 	path_lookup
depmod: 	remove_proc_entry
depmod: 	sock_no_sendpage
depmod: 	sock_no_listen
depmod: 	csum_partial
depmod: 	skb_over_panic
depmod: 	add_wait_queue
depmod: 	__scm_destroy
depmod: 	memcpy_fromiovec
depmod: 	sprintf
depmod: 	kmem_cache_destroy
depmod: 	sock_alloc_send_skb
depmod: 	printk
depmod: 	irq_stat
depmod: 	sock_register
depmod: 	dev_ioctl
depmod: 	register_sysctl_table
depmod: 	do_softirq
depmod: 	sock_no_mmap
depmod: 	sock_init_data
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/sound/oss/ac97=
_codec.ko
depmod: 	__get_user_4
depmod: 	snprintf
depmod: 	copy_to_user
depmod: 	sprintf
depmod: 	printk
depmod: 	__const_udelay
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/sound/oss/ad18=
48.ko
depmod: 	__get_user_4
depmod: 	pm_unregister
depmod: 	__release_region
depmod: 	isa_dma_bridge_buggy
depmod: 	kmalloc
depmod: 	__check_region
depmod: 	pnp_disable_dev
depmod: 	free_irq
depmod: 	pm_register
depmod: 	kfree
depmod: 	request_irq
depmod: 	put_device
depmod: 	pnp_activate_dev
depmod: 	sprintf
depmod: 	__request_region
depmod: 	printk
depmod: 	ioport_resource
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/sound/oss/emu1=
0k1/emu10k1.ko
depmod: 	__copy_to_user
depmod: 	__get_user_4
depmod: 	schedule_timeout
depmod: 	__wake_up
depmod: 	pci_register_driver
depmod: 	__release_region
depmod: 	unregister_sound_dsp
depmod: 	dma_alloc_coherent
depmod: 	pci_bus_read_config_dword
depmod: 	kmalloc
depmod: 	pci_enable_device
depmod: 	__up_wakeup
depmod: 	create_proc_entry
depmod: 	kernel_flag
depmod: 	__get_free_pages
depmod: 	no_llseek
depmod: 	unregister_sound_midi
depmod: 	free_irq
depmod: 	tasklet_kill
depmod: 	copy_to_user
depmod: 	register_sound_dsp
depmod: 	free_pages
depmod: 	register_sound_mixer
depmod: 	unregister_sound_mixer
depmod: 	proc_mkdir
depmod: 	interruptible_sleep_on
depmod: 	pci_set_dma_mask
depmod: 	kfree
depmod: 	__copy_from_user
depmod: 	remove_proc_entry
depmod: 	request_irq
depmod: 	pci_bus_read_config_word
depmod: 	pci_unregister_driver
depmod: 	pci_set_master
depmod: 	mem_map
depmod: 	register_sound_midi
depmod: 	sprintf
depmod: 	copy_from_user
depmod: 	__tasklet_hi_schedule
depmod: 	jiffies
depmod: 	tasklet_init
depmod: 	__request_region
depmod: 	printk
depmod: 	ioport_resource
depmod: 	dma_free_coherent
depmod: 	pci_bus_read_config_byte
depmod: 	__down_failed
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/sound/oss/mpu4=
01.ko
depmod: 	__get_user_4
depmod: 	__release_region
depmod: 	kmalloc
depmod: 	__check_region
depmod: 	free_irq
depmod: 	copy_to_user
depmod: 	kfree
depmod: 	request_irq
depmod: 	sprintf
depmod: 	copy_from_user
depmod: 	__request_region
depmod: 	printk
depmod: 	ioport_resource
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/sound/oss/sb.k=
o
depmod: 	vfree
depmod: 	printk
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/sound/oss/sb_l=
ib.ko
depmod: 	__get_user_4
depmod: 	__release_region
depmod: 	kmalloc
depmod: 	__check_region
depmod: 	mod_firmware_load
depmod: 	free_irq
depmod: 	kfree
depmod: 	request_irq
depmod: 	sprintf
depmod: 	copy_from_user
depmod: 	jiffies
depmod: 	__request_region
depmod: 	printk
depmod: 	__const_udelay
depmod: 	ioport_resource
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/sound/oss/soun=
d.ko
depmod: 	remap_page_range
depmod: 	__copy_to_user
depmod: 	__get_user_1
depmod: 	__get_user_4
depmod: 	del_timer_sync
depmod: 	__wake_up
depmod: 	schedule
depmod: 	unregister_sound_dsp
depmod: 	isa_dma_bridge_buggy
depmod: 	free_dma
depmod: 	kernel_flag
depmod: 	__get_free_pages
depmod: 	vfree
depmod: 	no_llseek
depmod: 	unregister_sound_midi
depmod: 	panic
depmod: 	copy_to_user
depmod: 	register_sound_dsp
depmod: 	free_pages
depmod: 	register_sound_mixer
depmod: 	interruptible_sleep_on_timeout
depmod: 	unregister_sound_mixer
depmod: 	request_module
depmod: 	unregister_sound_special
depmod: 	request_dma
depmod: 	del_timer
depmod: 	interruptible_sleep_on
depmod: 	vmalloc
depmod: 	register_sound_special
depmod: 	__copy_from_user
depmod: 	dma_spin_lock
depmod: 	mem_map
depmod: 	register_sound_midi
depmod: 	sprintf
depmod: 	copy_from_user
depmod: 	jiffies
depmod: 	printk
depmod: 	add_timer
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/sound/oss/trix=
.ko
depmod: 	__release_region
depmod: 	__check_region
depmod: 	mod_firmware_load
depmod: 	vfree
depmod: 	__request_region
depmod: 	printk
depmod: 	ioport_resource
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/sound/oss/uart=
401.ko
depmod: 	__release_region
depmod: 	kmalloc
depmod: 	free_irq
depmod: 	kfree
depmod: 	request_irq
depmod: 	__request_region
depmod: 	printk
depmod: 	ioport_resource
depmod: *** Unresolved symbols in /lib/modules/2.5.53/kernel/sound/oss/v_mi=
di.ko
depmod: 	kmalloc
depmod: 	kfree
depmod: 	printk

--=-iOZY2yUDbxtRVBwrpNOF
Content-Disposition: attachment; filename=config
Content-Type: text/plain; name=config; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

#
# Automatically generated make config: don't edit
#
CONFIG_X86=3Dy
CONFIG_MMU=3Dy
CONFIG_SWAP=3Dy
CONFIG_UID16=3Dy
CONFIG_GENERIC_ISA_DMA=3Dy

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=3Dy

#
# General setup
#
CONFIG_NET=3Dy
CONFIG_SYSVIPC=3Dy
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=3Dy

#
# Loadable module support
#
CONFIG_MODULES=3Dy
# CONFIG_MODULE_UNLOAD is not set
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=3Dy
CONFIG_KMOD=3Dy

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
CONFIG_MPENTIUMIII=3Dy
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_CMPXCHG=3Dy
CONFIG_X86_XADD=3Dy
CONFIG_X86_L1_CACHE_SHIFT=3D5
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_X86_WP_WORKS_OK=3Dy
CONFIG_X86_INVLPG=3Dy
CONFIG_X86_BSWAP=3Dy
CONFIG_X86_POPAD_OK=3Dy
CONFIG_X86_TSC=3Dy
CONFIG_X86_GOOD_APIC=3Dy
CONFIG_X86_INTEL_USERCOPY=3Dy
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
# CONFIG_HUGETLB_PAGE is not set
CONFIG_SMP=3Dy
# CONFIG_PREEMPT is not set
CONFIG_X86_LOCAL_APIC=3Dy
CONFIG_X86_IO_APIC=3Dy
CONFIG_NR_CPUS=3D32
# CONFIG_X86_NUMA is not set
CONFIG_X86_MCE=3Dy
# CONFIG_X86_MCE_NONFATAL is not set
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
# CONFIG_EDD is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=3Dy
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=3Dy
# CONFIG_HIGHPTE is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_MTRR is not set
CONFIG_HAVE_DEC_LOCK=3Dy

#
# Power management options (ACPI, APM)
#
CONFIG_PM=3Dy
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI Support
#
# CONFIG_ACPI is not set
# CONFIG_APM is not set
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=3Dy
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=3Dy
CONFIG_PCI_BIOS=3Dy
CONFIG_PCI_DIRECT=3Dy
# CONFIG_SCx200 is not set
CONFIG_PCI_NAMES=3Dy
CONFIG_ISA=3Dy
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=3Dy

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=3Dy
CONFIG_CARDBUS=3Dy
# CONFIG_I82092 is not set
# CONFIG_I82365 is not set
# CONFIG_TCIC is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_KCORE_ELF=3Dy
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=3Dy
CONFIG_BINFMT_ELF=3Dy
CONFIG_BINFMT_MISC=3Dy

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=3Dm
CONFIG_PARPORT_PC=3Dm
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_PC_PCMCIA is not set
# CONFIG_PARPORT_OTHER is not set
# CONFIG_PARPORT_1284 is not set

#
# Plug and Play support
#
CONFIG_PNP=3Dy
# CONFIG_PNP_NAMES is not set
# CONFIG_PNP_CARD is not set
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
# CONFIG_PNPBIOS is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=3Dm
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=3Dm
CONFIG_BLK_DEV_NBD=3Dm
CONFIG_BLK_DEV_RAM=3Dm
CONFIG_BLK_DEV_RAM_SIZE=3D4096
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL device support
#
CONFIG_IDE=3Dy

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=3Dy

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=3Dy
CONFIG_IDEDISK_MULTI_MODE=3Dy
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=3Dy
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=3Dm
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_BLK_DEV_CMD640=3Dy
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
CONFIG_BLK_DEV_IDEPCI=3Dy
# CONFIG_BLK_DEV_GENERIC is not set
CONFIG_IDEPCI_SHARE_IRQ=3Dy
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
# CONFIG_BLK_DEV_IDE_TCQ is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=3Dy
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=3Dy
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=3Dy
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=3Dy
# CONFIG_BLK_DEV_NFORCE is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
CONFIG_BLK_DEV_RZ1000=3Dy
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=3Dy
# CONFIG_IDEDMA_IVB is not set
CONFIG_BLK_DEV_IDE_MODES=3Dy

#
# SCSI device support
#
CONFIG_SCSI=3Dm

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=3Dm
CONFIG_CHR_DEV_ST=3Dm
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=3Dm
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=3Dm

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=3Dy
# CONFIG_SCSI_REPORT_LUNS is not set
CONFIG_SCSI_CONSTANTS=3Dy
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=3Dm
CONFIG_AIC7XXX_CMDS_PER_DEVICE=3D253
CONFIG_AIC7XXX_RESET_DELAY_MS=3D15000
# CONFIG_AIC7XXX_PROBE_EISA_VL is not set
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
CONFIG_AIC7XXX_DEBUG_ENABLE=3Dy
CONFIG_AIC7XXX_DEBUG_MASK=3D0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=3Dy
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
CONFIG_SCSI_PPA=3Dm
CONFIG_SCSI_IMM=3Dm
CONFIG_SCSI_IZIP_EPP16=3Dy
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
CONFIG_SCSI_SYM53C8XX=3Dm
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=3D4
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=3D32
CONFIG_SCSI_NCR53C8XX_SYNC=3D20
# CONFIG_SCSI_NCR53C8XX_PROFILE is not set
# CONFIG_SCSI_NCR53C8XX_IOMAPPED is not set
# CONFIG_SCSI_NCR53C8XX_PQS_PDS is not set
# CONFIG_SCSI_NCR53C8XX_SYMBIOS_COMPAT is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# PCMCIA SCSI adapter support
#
# CONFIG_SCSI_PCMCIA is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
CONFIG_I2O=3Dm
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
CONFIG_I2O_SCSI=3Dm
CONFIG_I2O_PROC=3Dm

#
# Networking options
#
CONFIG_PACKET=3Dy
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
CONFIG_NETFILTER=3Dy
CONFIG_NETFILTER_DEBUG=3Dy
CONFIG_FILTER=3Dy
CONFIG_UNIX=3Dm
# CONFIG_NET_KEY is not set
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=3Dm
CONFIG_NET_IPGRE=3Dm
# CONFIG_NET_IPGRE_BROADCAST is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_XFRM_USER is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=3Dm
CONFIG_IP_NF_FTP=3Dm
CONFIG_IP_NF_IRC=3Dm
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=3Dm
CONFIG_IP_NF_MATCH_LIMIT=3Dm
CONFIG_IP_NF_MATCH_MAC=3Dm
CONFIG_IP_NF_MATCH_PKTTYPE=3Dm
CONFIG_IP_NF_MATCH_MARK=3Dm
CONFIG_IP_NF_MATCH_MULTIPORT=3Dm
CONFIG_IP_NF_MATCH_TOS=3Dm
CONFIG_IP_NF_MATCH_ECN=3Dm
CONFIG_IP_NF_MATCH_DSCP=3Dm
CONFIG_IP_NF_MATCH_AH_ESP=3Dm
CONFIG_IP_NF_MATCH_LENGTH=3Dm
CONFIG_IP_NF_MATCH_TTL=3Dm
CONFIG_IP_NF_MATCH_TCPMSS=3Dm
CONFIG_IP_NF_MATCH_HELPER=3Dm
CONFIG_IP_NF_MATCH_STATE=3Dm
CONFIG_IP_NF_MATCH_CONNTRACK=3Dm
# CONFIG_IP_NF_MATCH_UNCLEAN is not set
# CONFIG_IP_NF_MATCH_OWNER is not set
CONFIG_IP_NF_FILTER=3Dm
CONFIG_IP_NF_TARGET_REJECT=3Dm
# CONFIG_IP_NF_TARGET_MIRROR is not set
CONFIG_IP_NF_NAT=3Dm
CONFIG_IP_NF_NAT_NEEDED=3Dy
CONFIG_IP_NF_TARGET_MASQUERADE=3Dm
CONFIG_IP_NF_TARGET_REDIRECT=3Dm
# CONFIG_IP_NF_NAT_LOCAL is not set
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_NAT_IRC=3Dm
CONFIG_IP_NF_NAT_FTP=3Dm
# CONFIG_IP_NF_MANGLE is not set
CONFIG_IP_NF_TARGET_LOG=3Dm
CONFIG_IP_NF_TARGET_ULOG=3Dm
CONFIG_IP_NF_TARGET_TCPMSS=3Dm
CONFIG_IP_NF_ARPTABLES=3Dm
CONFIG_IP_NF_ARPFILTER=3Dm
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
# CONFIG_IPV6 is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=3Dy
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set

#
# Network device support
#
CONFIG_NETDEVICES=3Dy

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=3Dm
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=3Dy
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=3Dy
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
CONFIG_VORTEX=3Dm
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
# CONFIG_NET_PCI is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices (depends on LLC=3Dy)
#
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# PCMCIA network device support
#
CONFIG_NET_PCMCIA=3Dy
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_PCMCIA_PCNET=3Dy
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_PCMCIA_AXNET is not set
CONFIG_NET_PCMCIA_RADIO=3Dy
CONFIG_PCMCIA_RAYCS=3Dy

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=3Dy

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=3Dy
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=3Dy
CONFIG_SERIO=3Dy
CONFIG_SERIO_I8042=3Dy
CONFIG_SERIO_SERPORT=3Dy
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=3Dy
CONFIG_KEYBOARD_ATKBD=3Dy
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=3Dy
CONFIG_MOUSE_PS2=3Dy
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Character devices
#
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_HW_CONSOLE=3Dy
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
CONFIG_UNIX98_PTYS=3Dy
CONFIG_UNIX98_PTY_COUNT=3D256
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_AMD_RNG is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=3Dy
# CONFIG_AGP3 is not set
CONFIG_AGP_INTEL=3Dy
CONFIG_AGP_VIA=3Dy
CONFIG_AGP_AMD=3Dy
CONFIG_AGP_SIS=3Dy
CONFIG_AGP_ALI=3Dy
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_AMD_8151 is not set
CONFIG_DRM=3Dy
CONFIG_DRM_TDFX=3Dy
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=3Dy
CONFIG_DRM_I810=3Dy
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_MGA is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=3Dy

#
# Video For Linux
#
# CONFIG_VIDEO_PROC_FS is not set

#
# Video Adapters
#
CONFIG_VIDEO_PMS=3Dm
CONFIG_VIDEO_BWQCAM=3Dm
CONFIG_VIDEO_CQCAM=3Dm
CONFIG_VIDEO_CPIA=3Dm
CONFIG_VIDEO_CPIA_USB=3Dm
# CONFIG_VIDEO_STRADIS is not set

#
# Radio Adapters
#
# CONFIG_RADIO_CADET is not set
# CONFIG_RADIO_RTRACK is not set
# CONFIG_RADIO_RTRACK2 is not set
# CONFIG_RADIO_AZTECH is not set
# CONFIG_RADIO_GEMTEK is not set
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set
# CONFIG_RADIO_SF16FMI is not set
# CONFIG_RADIO_TERRATEC is not set
# CONFIG_RADIO_TRUST is not set
# CONFIG_RADIO_TYPHOON is not set
# CONFIG_RADIO_ZOLTRIX is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# File systems
#
CONFIG_QUOTA=3Dy
# CONFIG_QFMT_V1 is not set
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=3Dy
CONFIG_AUTOFS_FS=3Dm
CONFIG_AUTOFS4_FS=3Dm
CONFIG_REISERFS_FS=3Dm
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=3Dm
CONFIG_EXT3_FS_XATTR=3Dy
# CONFIG_EXT3_FS_POSIX_ACL is not set
CONFIG_JBD=3Dy
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=3Dm
CONFIG_MSDOS_FS=3Dm
CONFIG_VFAT_FS=3Dm
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=3Dm
CONFIG_TMPFS=3Dy
CONFIG_RAMFS=3Dy
CONFIG_ISO9660_FS=3Dm
CONFIG_JOLIET=3Dy
CONFIG_ZISOFS=3Dy
CONFIG_JFS_FS=3Dm
# CONFIG_JFS_POSIX_ACL is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
CONFIG_NTFS_FS=3Dm
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=3Dy
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=3Dy
# CONFIG_QNX4FS_FS is not set
CONFIG_ROMFS_FS=3Dm
CONFIG_EXT2_FS=3Dy
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_SYSV_FS is not set
CONFIG_UDF_FS=3Dm
# CONFIG_UFS_FS is not set
# CONFIG_XFS_FS is not set

#
# Network File Systems
#
CONFIG_CODA_FS=3Dm
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=3Dm
CONFIG_NFS_V3=3Dy
# CONFIG_NFS_V4 is not set
CONFIG_NFSD=3Dm
# CONFIG_NFSD_V3 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_SUNRPC=3Dm
CONFIG_LOCKD=3Dm
CONFIG_LOCKD_V4=3Dy
CONFIG_EXPORTFS=3Dm
# CONFIG_CIFS is not set
CONFIG_SMB_FS=3Dm
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_NCP_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_ZISOFS_FS=3Dm
CONFIG_FS_MBCACHE=3Dy

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=3Dy
CONFIG_SMB_NLS=3Dy
CONFIG_NLS=3Dy

#
# Native Language Support
#
CONFIG_NLS_DEFAULT=3D"iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Graphics support
#
# CONFIG_FB is not set
CONFIG_VIDEO_SELECT=3Dy

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=3Dy
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=3Dy

#
# Sound
#
CONFIG_SOUND=3Dy

#
# Open Sound System
#
CONFIG_SOUND_PRIME=3Dm
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
CONFIG_SOUND_EMU10K1=3Dm
CONFIG_MIDI_EMU10K1=3Dy
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
CONFIG_SOUND_OSS=3Dm
CONFIG_SOUND_TRACEINIT=3Dy
CONFIG_SOUND_DMAP=3Dy
# CONFIG_SOUND_AD1816 is not set
# CONFIG_SOUND_SGALAXY is not set
# CONFIG_SOUND_ADLIB is not set
# CONFIG_SOUND_ACI_MIXER is not set
# CONFIG_SOUND_CS4232 is not set
# CONFIG_SOUND_SSCAPE is not set
# CONFIG_SOUND_GUS is not set
CONFIG_SOUND_VMIDI=3Dm
CONFIG_SOUND_TRIX=3Dm
CONFIG_SOUND_MSS=3Dm
CONFIG_SOUND_MPU401=3Dm
# CONFIG_SOUND_NM256 is not set
# CONFIG_SOUND_MAD16 is not set
# CONFIG_SOUND_PAS is not set
# CONFIG_SOUND_PSS is not set
CONFIG_SOUND_SB=3Dm
# CONFIG_SOUND_AWE32_SYNTH is not set
# CONFIG_SOUND_WAVEFRONT is not set
# CONFIG_SOUND_MAUI is not set
# CONFIG_SOUND_YM3812 is not set
# CONFIG_SOUND_OPL3SA1 is not set
# CONFIG_SOUND_OPL3SA2 is not set
# CONFIG_SOUND_YMFPCI is not set
# CONFIG_SOUND_UART6850 is not set
# CONFIG_SOUND_AEDSP16 is not set

#
# Advanced Linux Sound Architecture
#
# CONFIG_SND is not set

#
# USB support
#
CONFIG_USB=3Dm
CONFIG_USB_DEBUG=3Dy

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=3Dy
CONFIG_USB_BANDWIDTH=3Dy
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_OHCI_HCD=3Dm
CONFIG_USB_UHCI_HCD=3Dm

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
CONFIG_USB_ACM=3Dm
CONFIG_USB_PRINTER=3Dm
CONFIG_USB_STORAGE=3Dm
CONFIG_USB_STORAGE_DEBUG=3Dy
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
CONFIG_USB_STORAGE_HP8200e=3Dy
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=3Dm
# CONFIG_USB_HIDINPUT is not set
# CONFIG_USB_HIDDEV is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_XPAD is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
CONFIG_USB_SCANNER=3Dm
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set
# CONFIG_USB_VICAM is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_KONICAWC is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_PWC is not set
# CONFIG_USB_SE401 is not set
# CONFIG_USB_STV680 is not set

#
# USB Network adaptors
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_TEST is not set

#
# Bluetooth support
#
# CONFIG_BT is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
# CONFIG_KALLSYMS is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_X86_EXTRA_IRQS=3Dy
CONFIG_X86_FIND_SMP_CONFIG=3Dy
CONFIG_X86_MPPARSE=3Dy

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
# CONFIG_CRC32 is not set
CONFIG_ZLIB_INFLATE=3Dm
CONFIG_X86_SMP=3Dy
CONFIG_X86_HT=3Dy
CONFIG_X86_BIOS_REBOOT=3Dy

--=-iOZY2yUDbxtRVBwrpNOF--

--=-GgnW0JICjLKqXlKh/n3x
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA+EIZIsvQlVyd+QikRAru1AKCh03lOx5dpxb+08TqSIrMp0274YgCfTTLg
6Zv0J6IBlO/QQnS79/TfznQ=
=tWLv
-----END PGP SIGNATURE-----

--=-GgnW0JICjLKqXlKh/n3x--

