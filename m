Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265382AbTBBPdX>; Sun, 2 Feb 2003 10:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265385AbTBBPdX>; Sun, 2 Feb 2003 10:33:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54799 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265382AbTBBPdW>;
	Sun, 2 Feb 2003 10:33:22 -0500
Message-ID: <3E3D3C55.2090805@pobox.com>
Date: Sun, 02 Feb 2003 10:42:13 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Buchanan <jamesbuch@iprimus.com.au>
CC: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: Anyone supporting Intel 8XX chipset???
References: <5.1.0.14.0.20030203000618.00a0eb20@pop.iprimus.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is anyone writing code to directly support features of the Intel 800 series
> chipsets?  I'm using the 8xx chipset docs from Intel to gradually
> implement (hopefully) all the features of the 800 series of chipsets.

[...]
> One thing: should I maintain the consistency of using /dev files?  Because there
> is a hardware random number generator in the 800 series chipsets, and I
> am wondering whether I should export this feature as a set of functions or
> a /dev file.  (Both??)


Methinks you need to find out what support already exists.

The hardware RNG driver has existed for years, as has 3D support and ATA 
support...

	Jeff




