Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161200AbWF0QyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161200AbWF0QyT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161205AbWF0QyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:54:19 -0400
Received: from mail.polish-dvd.com ([69.222.0.225]:52453 "HELO
	mail.webhostingstar.com") by vger.kernel.org with SMTP
	id S1161200AbWF0QyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:54:18 -0400
Message-ID: <20060627164259.7210.qmail@mail.webhostingstar.com>
From: "art" <art@usfltd.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.17-git12-SMP-PREEMPT-x86_64 - x86_64/oprofile/oprofile.ko
  needs unknown symbol set/unset_nmi_callback
Date: Tue, 27 Jun 2006 11:42:59 -0500
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-kernel@vger.kernel.org 

2.6.17-git12-SMP-PREEMPT-x86_64 -  x86_64/oprofile/oprofile.ko needs unknown 
symbol set/unset_nmi_callback 

...
INSTALL sound/usb/snd-usb-lib.ko
INSTALL sound/usb/usx2y/snd-usb-usx2y.ko
if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F System.map 
2.6.17-git12; fi
WARNING: /lib/modules/2.6.17-git12/kernel/arch/x86_64/oprofile/oprofile.ko 
needs unknown symbol unset_nmi_callback
WARNING: /lib/modules/2.6.17-git12/kernel/arch/x86_64/oprofile/oprofile.ko 
needs unknown symbol set_nmi_callback
sh /home/miro/rip/linux-git/linux-2.6.17/arch/x86_64/boot/install.sh 
2.6.17-git12 arch/x86_64/boot/bzImage System.map "/boot"
WARNING: /lib/modules/2.6.17-git12/kernel/arch/x86_64/oprofile/oprofile.ko 
needs unknown symbol unset_nmi_callback
WARNING: /lib/modules/2.6.17-git12/kernel/arch/x86_64/oprofile/oprofile.ko 
needs unknown symbol set_nmi_callback 

xboom 

art@usfltd.com
