Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284239AbRLWXod>; Sun, 23 Dec 2001 18:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284258AbRLWXoX>; Sun, 23 Dec 2001 18:44:23 -0500
Received: from hera.cwi.nl ([192.16.191.8]:5625 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S284239AbRLWXoP>;
	Sun, 23 Dec 2001 18:44:15 -0500
From: Andries.Brouwer@cwi.nl
Date: Sun, 23 Dec 2001 23:44:09 GMT
Message-Id: <UTC200112232344.XAA71327.aeb@cwi.nl>
To: cs@zip.com.au
Subject: Re: Configure.help editorial policy
Cc: esr@thyrsus.com, garfield@irving.iisd.sra.com,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[OT] man-pages-1.46 was released an hour ago or so.

Cameron Simpson asks:

> Just out of curiosity, is there anywhere in the kernel space
> where KB (et al) is _not_ used to mean a power of 2 value?

Disk sizes are given in decimal, so in the boot message

hda: 120064896 sectors (61473 MB) w/2048KiB Cache ...

the MB denotes (decimal) megabytes, while the KiB denotes
(binary) kibibytes.
Yes, the parenthetical parts are pleonastic both times.

Andries

