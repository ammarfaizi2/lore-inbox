Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263420AbTH0PNa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 11:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263419AbTH0PNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 11:13:30 -0400
Received: from wildsau.idv.uni.linz.at ([213.157.128.253]:44952 "EHLO
	wildsau.idv.uni.linz.at") by vger.kernel.org with ESMTP
	id S263420AbTH0PN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 11:13:28 -0400
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Message-Id: <200308271511.h7RFBFHu017520@wildsau.idv.uni.linz.at>
Subject: Re: usb-storage: how to ruin your hardware(?)
In-Reply-To: <200308221044.h7MAicrR005239@wildsau.idv.uni.linz.at>
To: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Date: Wed, 27 Aug 2003 17:11:14 +0200 (MET DST)
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > "after the first write the flash device failed entirely". That doen't 
> 
> no, I wrote several data to it, like partitioning it, writing /dev/zero
> to it and so on. I moved it from computer to computer to try booting from
> it, installed lilo on it and so on. After several hours of messing around
> with the device, it failed.

okidok.... I got an new flashdisk from the vendor, but managed to ruin
it again. anyway, I also managed to repair it again. the vendor ships
a seperate formating-tool, which will repair the device, even when you
get "SCSI sense key errors".

however, I still don't understand what's going on and *why* it is not
allowed to format the drive "at will". I'd also would like to know how
this vendor supplied formating-tool works. Possibly some vendor-specific
usb-commands to ... do what? hm. I can only guess.

I purchased another driver (TraxData, USB-1, 6 euros cheaper and it
my mainboard can even boot from this device).

by the way: the manufacturer is Panram, www.panram.com.tw/ ... does anyone
of you have experience with them? Is it likely that one gets documentation
from them?

thx
h.rosmanith

