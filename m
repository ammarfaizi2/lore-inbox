Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319392AbSILAyn>; Wed, 11 Sep 2002 20:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319393AbSILAyn>; Wed, 11 Sep 2002 20:54:43 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:1806 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S319392AbSILAym>; Wed, 11 Sep 2002 20:54:42 -0400
Date: Wed, 11 Sep 2002 17:57:51 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Samuel Flory <sflory@rackable.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: serial ata cards under linux
In-Reply-To: <3D7FE5DE.8080000@rackable.com>
Message-ID: <Pine.LNX.4.10.10209111755050.29877-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is no support for this card, and is not supportable until I obtain
their NDA docs.  You can not simply add in the device ID and make it go.

There is only support for Silicon Image 3112.

Serial ATA requires more than basic PATA compatablity.

Cheers,

On Wed, 11 Sep 2002, Samuel Flory wrote:

>   Are there any serial ata cards that work under linux?  The only ones I 
> know of are ata raid cards, and are bridged.  I've got a promise 
> PDC20375, but I don't see any sign of support for in in the linux kernel.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

