Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751585AbWIZSd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585AbWIZSd1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 14:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbWIZSd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 14:33:27 -0400
Received: from mail.gmx.de ([213.165.64.20]:42449 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751583AbWIZSd0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 14:33:26 -0400
X-Authenticated: #625117
Date: Tue, 26 Sep 2006 20:33:47 +0200
From: Dimitri Chausson <tri2000@gmx.net>
To: Dimitri Chausson <tri2000@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: serious kernel messages in /var/log/messages
Message-Id: <20060926203347.e4104924.tri2000@gmx.net>
In-Reply-To: <20060926195605.e0e9efa8.tri2000@gmx.net>
References: <20060926195605.e0e9efa8.tri2000@gmx.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__26_Sep_2006_20_33_47_+0200_L7_w2/LzuKVnr64t"
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Tue__26_Sep_2006_20_33_47_+0200_L7_w2/LzuKVnr64t
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Sep 2006 19:56:05 +0200
Dimitri Chausson <tri2000@gmx.net> wrote:

> Hi,
> 
> I am using a 2.6.16-2-k7 kernel and experiencing problems. The computer sometimes freezes (not only X), sometimes my terminal disappear as I am typing something in, so it's very difficult to find the reason. I already suspect a hardware problem, but I do not know what to start with. I also included two excerpts of my /var/log/messages after such problem occured. 
> Maybe some of you can give me a good hint. 
> I reinstalled my whole system on sunday, b/c I wanted to exclude the possibility of badly broken software.. but those abnormal logs appeared since,
> 
> thanks a lot for your time,
> 
> Dimitri
> 

one additional output in /var/log/messages, if it can help


Dimitri

--Multipart=_Tue__26_Sep_2006_20_33_47_+0200_L7_w2/LzuKVnr64t
Content-Type: text/plain;
 name="kernel_pb3.txt"
Content-Disposition: attachment;
 filename="kernel_pb3.txt"
Content-Transfer-Encoding: 7bit

Sep 26 20:27:58 localhost kernel: b01564f3
Sep 26 20:27:58 localhost kernel: Modules linked in: nls_iso8859_1 isofs udf ipt_TCPMSS xt_tcpmss xt_tcpudp iptable_mangle ip_tables x_tables pppoe pppox radeon drm ppdev lp button ac battery ipv6 ppp_generic slhc dm_mod loop bt878 tuner tvaudio msp3400 mousedev tsdev bttv video_buf firmware_class compat_ioctl32 i2c_algo_bit snd_via82xx v4l2_common btcx_risc ir_common snd_ymfpci i2c_viapro analog tveeprom snd_ac97_codec snd_ac97_bus snd_opl3_lib via_ircc sd_mod i2c_core via_agp snd_bt87x snd_mpu401 snd_hwdep snd_mpu401_uart gameport shpchp pci_hotplug irda videodev snd_rawmidi snd_seq_device psmouse pcspkr agpgart floppy parport_pc parport snd_pcm snd_timer snd snd_page_alloc crc_ccitt evdev serio_raw soundcore rtc ext3 jbd mbcache ide_cd cdrom ide_disk usb_storage scsi_mod via82cxxx via_rhine mii generic ide_core uhci_hcd usbcore thermal processor fan
Sep 26 20:27:58 localhost kernel: EIP:    0060:[<b01564f3>]    Not tainted VLI
Sep 26 20:27:58 localhost kernel: EFLAGS: 00210286   (2.6.16-2-k7 #1) 

--Multipart=_Tue__26_Sep_2006_20_33_47_+0200_L7_w2/LzuKVnr64t--
