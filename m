Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276675AbRJBUww>; Tue, 2 Oct 2001 16:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276677AbRJBUwn>; Tue, 2 Oct 2001 16:52:43 -0400
Received: from [195.66.192.167] ([195.66.192.167]:27401 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S276675AbRJBUwc>; Tue, 2 Oct 2001 16:52:32 -0400
Date: Tue, 2 Oct 2001 23:52:08 +0200
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <1094134264.20011002235208@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: Re: System reset on Kernel 2.4.10
In-Reply-To: <1091577748.20011002230931@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <Pine.LNX.4.33.0110022110070.21544-100000@vela.salleURL.edu>
 <3BBA1409.6AAA553D@welho.com>
 <1091577748.20011002230931@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

V> # su user
V> $ ./vmlinux
V> Segmentation fault
V> *** screen went blank, then POST screen appears ***

V> Straced vmlinux does not reboot.
V> Kernel: 2.4.10+ext3+preempt

Well... sometimes it reboots too.
Once it rebooted ~10 mins after strace (system was at zero load).
Also it rebooted after two strace's in succession.
-- 
Best regards, VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua


