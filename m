Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262005AbSJDUAC>; Fri, 4 Oct 2002 16:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261933AbSJDUAC>; Fri, 4 Oct 2002 16:00:02 -0400
Received: from web11607.mail.yahoo.com ([216.136.172.59]:28178 "HELO
	web11607.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S262004AbSJDT7o>; Fri, 4 Oct 2002 15:59:44 -0400
Message-ID: <20021004200517.13111.qmail@web11607.mail.yahoo.com>
Date: Fri, 4 Oct 2002 16:05:17 -0400 (EDT)
From: Giudicelli =?ISO-8859-1?Q?=22Fr=E9d=E9ric=22?= 
	<giudicelli@yahoo.com>
Subject: kernel-2.4.18-3 crash
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oct  4 20:38:31 server-web kernel: usb.c: USB
disconnect on device 1
Oct  4 20:38:31 server-web kernel: usb.c: USB
disconnect on device 4
Oct  4 20:38:31 server-web kernel: usbdevfs: process
1654 (pppoeci) did not claim interface 0 before use
Oct  4 20:38:31 server-web kernel: usb-uhci.c: forced
removing of queued URB c57ae7fc due to disconnect
Oct  4 20:38:31 server-web kernel: usb-uhci.c: forced
removing of queued URB c57ae37c due to disconnect
Oct  4 20:38:31 server-web kernel: usb-uhci.c: forced
removing of queued URB c57ae57c due to disconnect
Oct  4 20:38:31 server-web kernel: usb-uhci.c: forced
removing of queued URB c57aebfc due to disconnect
Oct  4 20:38:31 server-web kernel: usb-uhci.c: forced
removing of queued URB c57ae2fc due to disconnect
Oct  4 20:38:31 server-web kernel: usb-uhci.c: forced
removing of queued URB c473c67c due to disconnect
Oct  4 20:38:31 server-web kernel: usb-uhci.c: forced
removing of queued URB c473c57c due to disconnect
Oct  4 20:38:31 server-web kernel: usb-uhci.c: forced
removing of queued URB c473c47c due to disconnect
Oct  4 20:38:31 server-web kernel: usb-uhci.c: forced
removing of queued URB c473cdfc due to disconnect
Oct  4 20:38:31 server-web kernel: usb-uhci.c: forced
removing of queued URB c47b0bdc due to disconnect
Oct  4 20:38:31 server-web kernel: usb-uhci.c: forced
removing of queued URB c47b0c5c due to disconnect
Oct  4 20:38:31 server-web kernel: usb-uhci.c: forced
removing of queued URB c47b0edc due to disconnect
Oct  4 20:38:31 server-web kernel: usb-uhci.c: forced
removing of queued URB c47b0ddc due to disconnect
Oct  4 20:38:31 server-web kernel: usb-uhci.c: forced
removing of queued URB c47b0cdc due to disconnect
Oct  4 20:38:31 server-web kernel: usb-uhci.c: forced
removing of queued URB c47b04dc due to disconnect
Oct  4 20:38:31 server-web kernel: usb-uhci.c: forced
removing of queued URB c47b03dc due to disconnect
Oct  4 20:38:31 server-web kernel: usb-uhci.c: forced
removing of queued URB c47b02dc due to disconnect
Oct  4 20:38:31 server-web kernel: usb-uhci.c: forced
removing of queued URB c47b01dc due to disconnect
Oct  4 20:38:31 server-web kernel: usb-uhci.c: forced
removing of queued URB c47b00dc due to disconnect
Oct  4 20:38:31 server-web kernel: usb-uhci.c: forced
removing of queued URB c47b0a5c due to disconnect
Oct  4 20:38:31 server-web kernel: usb-uhci.c: forced
removing of queued URB c47b095c due to disconnect
Oct  4 20:38:31 server-web kernel: usb-uhci.c: forced
removing of queued URB c4b5681c due to disconnect
Oct  4 20:38:31 server-web kernel: usb-uhci.c: forced
removing of queued URB c515c21c due to disconnect
Oct  4 20:38:31 server-web kernel: usb-uhci.c: forced
removing of queued URB c515c81c due to disconnect
Oct  4 20:38:32 server-web kernel: usb-uhci.c: forced
removing of queued URB c47b075c due to disconnect
Oct  4 20:38:32 server-web kernel: usb-uhci.c: forced
removing of queued URB c4b56a1c due to disconnect
Oct  4 20:38:32 server-web kernel: usb-uhci.c: forced
removing of queued URB c4b56c1c due to disconnect
Oct  4 20:38:32 server-web kernel: usb-uhci.c: forced
removing of queued URB c53c9e3c due to disconnect
Oct  4 20:38:32 server-web kernel: usb-uhci.c: forced
removing of queued URB c57ae4fc due to disconnect
Oct  4 20:38:32 server-web kernel: usb-uhci.c: forced
removing of queued URB c566e81c due to disconnect
Oct  4 20:38:32 server-web kernel: usb-uhci.c: forced
removing of queued URB c566e61c due to disconnect
Oct  4 20:38:32 server-web kernel: usb-uhci.c: forced
removing of queued URB c4bbe25c due to disconnect
Oct  4 20:38:32 server-web kernel: usb.c: USB bus 1
deregistered
Oct  4 20:38:32 server-web kernel: pci_pool_destroy
00:07.2/uhci_desc, c21c4000 busy
Oct  4 20:38:32 server-web kernel: pci_pool_destroy
00:07.2/uhci_desc, c1c96000 busy
Oct  4 20:38:32 server-web kernel: pci_pool_destroy
00:07.2/uhci_desc, c13d9000 busy
Oct  4 20:38:32 server-web kernel: kmem_cache_destroy:
Can't free all objects c11c7bb0
Oct  4 20:38:32 server-web kernel: usb-uhci.c:
urb_priv_kmem remained
Oct  4 20:38:32 server-web kernel: Unable to handle
kernel paging request at virtual address c8862a18
Oct  4 20:38:32 server-web kernel:  printing eip:
Oct  4 20:38:32 server-web kernel: c8862a18
Oct  4 20:38:32 server-web kernel: *pde = 07fe4067
Oct  4 20:38:32 server-web kernel: *pte = 00000000
Oct  4 20:38:32 server-web kernel: Oops: 0000
Oct  4 20:38:32 server-web kernel: ipt_MASQUERADE
ipt_state iptable_nat ip_conntrack iptable_filter
ip_tables n_h
Oct  4 20:38:32 server-web kernel: CPU:    0
Oct  4 20:38:32 server-web kernel: EIP:   
0010:[<c8862a18>]    Not tainted
Oct  4 20:38:32 server-web kernel: EFLAGS: 00010282
Oct  4 20:38:33 server-web kernel:
Oct  4 20:38:33 server-web kernel: EIP is at
usb_devfs_handle_Re9c5f87f [usbcore] 0x2ca4 (2.4.18-3)
Oct  4 20:38:33 server-web kernel: eax: 00000000  
ebx: 00000286   ecx: c2ebded4   edx: 00000000
Oct  4 20:38:33 server-web kernel: esi: c515cc1c  
edi: c1569520   ebp: c7fa1a60   esp: c2ebdf00
Oct  4 20:38:33 server-web kernel: ds: 0018   es: 0018
  ss: 0018
Oct  4 20:38:33 server-web kernel: Process pppoeci
(pid: 1654, stackpage=c2ebd000)
Oct  4 20:38:33 server-web kernel: Stack: c66c0800
00000000 c4782274 c37b2820 c1569520 c515cc1c c7fa1a60
c6391320
Oct  4 20:38:33 server-web kernel:        c8862c8c
c7fa1a60 c515cc1c 00000246 c473c7e0 c473c804 c884f194
c515cc1c
Oct  4 20:38:33 server-web kernel:        c885313a
c515cc1c c473c7e0 c11c62e0 c4d85440 c88535d6 c473c7e0
c264c3e0
Oct  4 20:38:33 server-web kernel: Call Trace:
[<c884f194>] usb_unlink_urb_Ref84ad8c [usbcore] 0x24
Oct  4 20:38:33 server-web kernel: [<c885313a>]
destroy_all_async [usbcore] 0x3a
Oct  4 20:38:33 server-web kernel: [<c88535d6>]
usbdev_release [usbcore] 0x56
Oct  4 20:38:33 server-web kernel: [<c0139a7d>] fput
[kernel] 0x4d
Oct  4 20:38:33 server-web kernel: [<c01389a3>]
filp_close [kernel] 0x53
Oct  4 20:38:33 server-web kernel: [<c01389f3>]
sys_close [kernel] 0x43
Oct  4 20:38:33 server-web kernel: [<c0108923>]
system_call [kernel] 0x33
Oct  4 20:38:33 server-web kernel:
Oct  4 20:38:33 server-web kernel:
Oct  4 20:38:33 server-web kernel: Code:  Bad EIP
value.
Oct  4 20:38:33 server-web pppd[1665]: Modem hangup
Oct  4 20:38:33 server-web pppd[1665]: Connection
terminated.
Oct  4 20:38:33 server-web pppd[1665]: Connect time
1440.2 minutes.
Oct  4 20:38:33 server-web pppd[1665]: Sent 7673731
bytes, received 3706716 bytes.
Oct  4 20:38:34 server-web /etc/hotplug/net.agent: NET
unregister event not supported
Oct  4 20:39:04 server-web kernel:  ------------[ cut
here ]------------
Oct  4 20:39:04 server-web kernel: kernel BUG at
slab.c:815!
Oct  4 20:39:04 server-web kernel: invalid operand:
0000
Oct  4 20:39:04 server-web kernel: usb-uhci
ipt_MASQUERADE ipt_state iptable_nat ip_conntrack
iptable_filter ip_t
Oct  4 20:39:04 server-web kernel: CPU:    0
Oct  4 20:39:04 server-web kernel: EIP:   
0010:[<c012e33a>]    Not tainted
Oct  4 20:39:04 server-web kernel: EFLAGS: 00010286
Oct  4 20:39:04 server-web kernel:
Oct  4 20:39:04 server-web kernel: EIP is at
kmem_cache_create [kernel] 0x32a (2.4.18-3)
Oct  4 20:39:04 server-web kernel: eax: 0000001a  
ebx: c11c7c18   ecx: 00000001   edx: 00003a36
Oct  4 20:39:04 server-web kernel: esi: c11c7c0d  
edi: c8865b98   ebp: c11c7d00   esp: c476fed8
Oct  4 20:39:04 server-web kernel: ds: 0018   es: 0018
  ss: 0018
Oct  4 20:39:04 server-web kernel: Process insmod
(pid: 2061, stackpage=c476f000)
Oct  4 20:39:05 server-web kernel: Stack: c022500e
0000032f c476fee4 00000020 c8861000 00000001 00000001
00000001
Oct  4 20:39:05 server-web pppd[1665]: Terminating on
signal 15.
Oct  4 20:39:05 server-web kernel:        c8864f4c
c8865b8f 00000040 00000020 00022000 00000000 00000000
ffffffff
Oct  4 20:39:05 server-web kernel:        000002e6
c8861000 00000001 c8861000 00000001 c0118e65 c8866164
c13fa000
Oct  4 20:39:05 server-web kernel: Call Trace:
[<c8864f4c>] uhci_hcd_init [usb-uhci] 0x1c
Oct  4 20:39:05 server-web kernel: [<c8865b8f>]
.rodata.str1.1 [usb-uhci] 0x10f
Oct  4 20:39:05 server-web kernel: [<c0118e65>]
sys_init_module [kernel] 0x535
Oct  4 20:39:05 server-web kernel: [<c8866164>]
.kmodtab [usb-uhci] 0x0
Oct  4 20:39:05 server-web kernel: [<c8861060>]
uhci_show_qh [usb-uhci] 0x0
Oct  4 20:39:05 server-web kernel: [<c0108923>]
system_call [kernel] 0x33
Oct  4 20:39:05 server-web kernel:
Oct  4 20:39:05 server-web kernel:
Oct  4 20:39:06 server-web kernel: Code: 0f 0b 5a 59
8b 1b 81 fb 48 45 2c c0 75 c8 8b 15 48 45 2c c0


______________________________________________________________________ 
Post your free ad now! http://personals.yahoo.ca
