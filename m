Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286186AbRLZJXJ>; Wed, 26 Dec 2001 04:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286187AbRLZJW7>; Wed, 26 Dec 2001 04:22:59 -0500
Received: from unicef.org.yu ([194.247.200.148]:59661 "EHLO unicef.org.yu")
	by vger.kernel.org with ESMTP id <S286186AbRLZJWs>;
	Wed, 26 Dec 2001 04:22:48 -0500
Date: Wed, 26 Dec 2001 10:22:28 +0100 (CET)
From: Davidovac Zoran <zdavid@unicef.org.yu>
To: Robert Jameson <rj@open-net.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: CDROM stop's working 15mins after being mounted
In-Reply-To: <20011226034203.5889d583.rj@open-net.org>
Message-ID: <Pine.LNX.4.33.0112261013330.27733-100000@unicef.org.yu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Dec 2001, Robert Jameson wrote:

> Hi, I recently noticed with 2.4.17 using scsi cdrom emulation my cdrom stop's functioning after monunting it, (and reading from it). I think hafta umount and remount it, I didnt see these problems with 2.4.16, has anyone else had this problem?
> --

I have no problem with  using scsi cdrom emulation ,
using teac 58E RW and ide-scsi emulation.

Only problem I found is when writing TOC (within cdrecord)
I have to wait until it finished (I cannot even change console)
to be more strange, I have that problem only at work
PIII 500Mhz with TEAC 58E but on
PII 633Mhz with TEAC 54E and PPRO 200Mhz with TEAC 58E I haven't
that problem. Note that was for 2.4.14-17

With kernel 2.2.19 there is no such behaviur.


Regards,

 Zoran

