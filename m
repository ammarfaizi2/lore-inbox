Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbUEVP0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbUEVP0v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 11:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbUEVP0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 11:26:35 -0400
Received: from smtp3.libero.it ([193.70.192.127]:56488 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id S261426AbUEVP0U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 11:26:20 -0400
From: Cybermario <cybermario@libero.it>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 
Date: Sat, 22 May 2004 17:30:53 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405221730.53890.cybermario@libero.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux cybermario 2.6.6 #1 SMP Mon May 10 00:15:32 PDT 2004 i686 unknown 
unknown GNU/Linux

Gnu C                  3.4.0
Gnu make               3.80
binutils               2.14
util-linux             2.12a
mount                  2.12a
module-init-tools      0.9.14
e2fsprogs              1.35
PPP                    2.4.2
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      6.0.0
Procps                 3.2.1
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         ppp_deflate zlib_deflate bsd_comp ppp_async 
iptable_filter ip_tables pciehp pci_hotplug forcedeth ohci_hcd ppp_generic 
slhc usb_storage parport_pc lp parport snd_seq_oss snd_seq_midi_event snd_seq 
snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_pcm snd_timer 
snd_page_alloc gameport snd_mpu401_uart snd_rawmidi snd_seq_device snd 
soundcore nvidia ide_floppy rtc ntfs nls_cp437 vfat fat

I don't know if this could be e problem but my distro (the scsi version) 
report this error in kernel.log:

May 18 23:15:06 cybermario kernel:  /dev/ide/host0/bus0/target1/lun0: p1
May 18 23:15:06 cybermario kernel: hdb: task_no_data_intr: status=0x51 
{ DriveReady SeekComplete Error }
May 18 23:15:06 cybermario kernel: hdb: task_no_data_intr: error=0x04 
{ DriveStatusError }
May 18 23:15:06 cybermario kernel: hdb: Write Cache FAILED Flushing!

Thanks for your attention.
-- 

Ciao Cybermario
