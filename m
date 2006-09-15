Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWIOIjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWIOIjd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 04:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWIOIjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 04:39:32 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:59056 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750757AbWIOIjb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 04:39:31 -0400
Date: Fri, 15 Sep 2006 10:39:11 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Razvan Gavril <razvan.g@plutohome.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Some ooupses with 2.6.18rc7
In-Reply-To: <450A64CC.5060008@plutohome.com>
Message-ID: <Pine.LNX.4.61.0609151038220.11214@yvahk01.tjqt.qr>
References: <450A64CC.5060008@plutohome.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 2.3 points, 6.0 required
	2.3 UNIQUE_WORDS           BODY: Message body has many words used only once
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Modules linked in: ide_generic bttv video_buf firmware_class rfcomm
> ir_common compat_ioctl32 i2c_algo_bit l2cap btcx_risc tveeprom
> videodev v4l1_compat v4l2_common ipt_TCPMSS xt_tcpudp xt_mark
> xt_state iptable_nat iptable_filter ip_tables x_tables nfsd exportfs
> lockd nfs_acl sunrpc ext2 autofs4 nvidia agpgart ipv6 vga16fb
                                    ^^^^^^

Run a kernel without that, then we'll see.

> vgastate mousedev ip_nat_irc ip_nat_ftp ip_nat ip_conntrack_irc
> ip_conntrack_ftp ip_conntrack nfnetlink sr_mod sbp2 hci_usb bluetooth
> snd_hda_intel snd_hda_codec snd_pcm_oss snd_mixer_oss snd_pcm analog
> eth1394 psmouse ftdi_sio gameport snd_mpu401 serio_raw evdev joydev
> snd_mpu401_uart snd_rawmidi snd_seq_device parport_pc parport
> snd_timer rtc floppy snd soundcore i2c_nforce2 snd_page_alloc pl2303
> i2c_core usbserial ext3 jbd mbcache 8139too sd_mod ide_cd cdrom
> ide_disk usbhid sata_nv libata scsi_mod 8139cp mii ohci1394 ieee1394
> ehci_hcd forcedeth amd74xx generic ide_core ohci_hcd usbcore



Jan Engelhardt
-- 
