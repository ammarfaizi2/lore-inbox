Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317454AbSF1PKL>; Fri, 28 Jun 2002 11:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317463AbSF1PKK>; Fri, 28 Jun 2002 11:10:10 -0400
Received: from [62.70.58.70] ([62.70.58.70]:5765 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S317454AbSF1PKJ> convert rfc822-to-8bit;
	Fri, 28 Jun 2002 11:10:09 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: USB doesn't work
Date: Fri, 28 Jun 2002 17:12:34 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <mailman.1025183101.8745.linux-kernel2news@redhat.com> <200206281504.g5SF4rA19032@devserv.devel.redhat.com>
In-Reply-To: <200206281504.g5SF4rA19032@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206281712.34860.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 June 2002 17:04, Pete Zaitcev wrote:
> > Running 2.4.19-rc1 or 2.4.18, the following chipset won't work with a
> > USB= =20
> > keyboard attached:
> >
> > usb-ohci.c: USB OHCI at membase 0xc4802000, IRQ 10
> > usb-ohci.c: usb-00:13.0, Compaq Computer Corporation ZFMicro Chipset USB
> > usb-ohci.c: USB HC TakeOver failed!
>
> This is a BIOS screwage. What was the last kernel that worked?

It's never worked. I've actually given up - it was during some testing of some 
Samsung early prototype set-top-computers ... They hang if I try to disable 
USB legacy support in BIOS. They hang if I try to reboot, and they hang if I 
use red post-it notes on them

thanks anyway

roy

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

