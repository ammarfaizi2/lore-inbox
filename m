Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289121AbSAJDO6>; Wed, 9 Jan 2002 22:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289126AbSAJDOs>; Wed, 9 Jan 2002 22:14:48 -0500
Received: from mgr1.xmission.com ([198.60.22.201]:51208 "EHLO
	mgr1.xmission.com") by vger.kernel.org with ESMTP
	id <S289121AbSAJDOe>; Wed, 9 Jan 2002 22:14:34 -0500
Message-ID: <3C3D0718.2060602@xmission.com>
Date: Wed, 09 Jan 2002 20:14:32 -0700
From: Benjamin S Carrell <ben@xmission.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Bigggg Maxtor drives (fwd)
In-Reply-To: <Pine.LNX.4.10.10201091745470.5104-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would think that you lose that space to formatting (would it not get 
the size of the drive from the bios?), but I stand open for correction.

-Ben Carrell
ben@xmission.com

Andre Hedrick wrote:

>another update request --
>
>
>---------- Forwarded message ----------
>Date: Mon, 31 Dec 2001 12:16:12 -0800
>From: ablew@internetcds.com
>To: andre@linux-ide.org
>Subject: Bigggg Maxtor drives
>
>Hi there.  As I understand it you're the linux IDE guy,
>so if you don't mind answering a question for me, I'd
>appriciate it.
>
>I recently bought a Maxtor 4G160J8.  This hard drive is
>Maxtor's biggest harddrive as of yet, coming in at
>160GB.  Linux sees this drive as a mere 134 or so gigs
>as shown by the below:
>
>hde: Maxtor 4G160J8, ATA DISK drive
>hde: 268435455 sectors (137439 MB) w/2048KiB Cache,
>CHS=266305/16/63, UDMA(33) hde: hde1
>
>Do I need to pass the kernel any arguments though grub
>to see the full size, or is this just a kernel level
>limitation?
>
>Any help is appriciated.
>
>Thanks,
>-Aaron
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>


