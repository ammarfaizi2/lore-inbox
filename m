Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317405AbSGDJG5>; Thu, 4 Jul 2002 05:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317407AbSGDJG4>; Thu, 4 Jul 2002 05:06:56 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:39925 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S317405AbSGDJG4>;
	Thu, 4 Jul 2002 05:06:56 -0400
Date: Thu, 4 Jul 2002 11:09:26 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: hd_geometry question.
Message-ID: <20020704090926.GA22609@win.tue.nl>
References: <20020703002039.GA22020@win.tue.nl> <Pine.LNX.4.44.0207040144500.8911-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207040144500.8911-100000@serv>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2002 at 01:48:33AM +0200, Roman Zippel wrote:

> > It is rumoured that certain MO disks with a hardware sector size
> > of 2048 bytes have partition tables in units of 2048-byte sectors.
> 
> Why is it a rumour? AFAIK under DOS/Windows the partition table is in
> units of sector size.

I assume you mean hardware sector size.

Yes, that is what I wrote in
	http://www.win.tue.nl/~aeb/partitions/partition_tables-2.html#ss2.1

Sector size different from 512 is rare, so it is a bit difficult to find
precise details. Do you have docs?
