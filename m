Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbTDHOWa (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 10:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbTDHOWa (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 10:22:30 -0400
Received: from HDOfa-01p2-156.ppp11.odn.ad.jp ([61.116.131.156]:64920 "HELO
	hokkemirin.dyndns.org") by vger.kernel.org with SMTP
	id S261814AbTDHOWa (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 10:22:30 -0400
Date: Tue, 08 Apr 2003 23:34:05 +0900 (JST)
Message-Id: <20030408.233405.74750582.whatisthis@jcom.home.ne.jp>
To: tiwai@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre7/PCI : Unable to attach Sound module of VIA686A 
From: Kyuma Ohta <whatisthis@jcom.home.ne.jp>
In-Reply-To: <s5hr88dqjc3.wl@alsa2.suse.de>
References: <s5h1y0esjov.wl@alsa2.suse.de>
	<20030407.212307.74751577.whatisthis@jcom.home.ne.jp>
	<s5hr88dqjc3.wl@alsa2.suse.de>
X-Mailer: Mew version 3.2 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Takashi,

 I tested this patch w/aic7xxx , that's OK.

Regards,
Ohta

------ /proc/ioports w/alsa-0.9.2 ------
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
d000-d00f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
  d000-d007 : ide0
  d008-d00f : ide1
d400-d41f : VIA Technologies, Inc. USB
  d400-d41f : usb-uhci
d800-d81f : VIA Technologies, Inc. USB (#2)
  d800-d81f : usb-uhci
dc00-dcff : VIA Technologies, Inc. VT82C686 AC97 Audio Controller
  dc00-dcff : VIA686A
e000-e003 : VIA Technologies, Inc. VT82C686 AC97 Audio Controller
e400-e403 : VIA Technologies, Inc. VT82C686 AC97 Audio Controller
  e400-e401 : MPU401 UART
e800-e8ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  e800-e8ff : 8139too
ec00-ecff : PCI device 1317:9511 (Linksys)
  ec00-ecff : tulip
