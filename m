Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264892AbSKNPdr>; Thu, 14 Nov 2002 10:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264934AbSKNPdr>; Thu, 14 Nov 2002 10:33:47 -0500
Received: from posti3.jyu.fi ([130.234.5.32]:60312 "EHLO posti3.jyu.fi")
	by vger.kernel.org with ESMTP id <S264892AbSKNPdq>;
	Thu, 14 Nov 2002 10:33:46 -0500
Date: Thu, 14 Nov 2002 17:40:38 +0200 (EET)
From: Jani Averbach <jaa@cc.jyu.fi>
To: Mike Dresser <mdresser_l@windsormachine.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: How do I re-activate IDE controller (secondary channel) after
 boot?
In-Reply-To: <Pine.LNX.4.33.0211141008480.10843-100000@router.windsormachine.com>
Message-ID: <Pine.GSO.4.33.0211141724410.20634-100000@tukki.cc.jyu.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2002, Mike Dresser wrote:

> Very odd BIOS, but that's a given.

indeed, sigh.

> What happens in case #1?

dmesg:
...
hdd: ST380021A, ATA DISK drive
...


cfdisk 2.11w:

Disk Drive: /dev/hdd
Size: 33820286976 bytes, 33.8 GB
Heads:16 Sectors per Track: 63 Cylinders: 65531


Real values from label on top of disk:
16,383 Cyl, 16 HDS, 63 Sect - 156,301,488 LBA


> I thought I remembered a way to get the full capacity after Linux has
> booted up, using that method.
>

Even when drive has been jumppered to 32G? Please tell. =)

BR, Jani

--
Jani Averbach

