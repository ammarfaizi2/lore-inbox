Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317101AbSHAVFn>; Thu, 1 Aug 2002 17:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317102AbSHAVFm>; Thu, 1 Aug 2002 17:05:42 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:65526 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317101AbSHAVFW>;
	Thu, 1 Aug 2002 17:05:22 -0400
Date: Thu, 1 Aug 2002 17:08:50 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Thunder from the hill <thunder@ngforever.de>
cc: Peter Chubb <peter@chubb.wattle.id.au>, Pavel Machek <pavel@ucw.cz>,
       Matt_Domsch@Dell.com, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.28 and partitions
In-Reply-To: <Pine.LNX.4.44.0208011440390.5119-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.GSO.4.21.0208011700580.12627-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Aug 2002, Thunder from the hill wrote:

> Hi,
> 
> On Thu, 1 Aug 2002, Alexander Viro wrote:
> > More powerful?
> 
> Well, compared to ASCII: it's unlikely that you meet a j letter or a \033 
> in the size string.

Huh???  That's a new meaning of "powerful"...  If you mean "more compact"
I would certainly agree (base-10 instead of base-256), but if _that_ becomes
a problem with partition tables...  IIRC, OP proposed 4096 bytes for table.

Again, if somebody really can't check if array of characters is a valid
representation of integer or can't implement conversion of known valid
one to its value...  What the devil are you doing here?

