Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315137AbSEDRyD>; Sat, 4 May 2002 13:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315138AbSEDRyC>; Sat, 4 May 2002 13:54:02 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:34038 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315137AbSEDRyB>;
	Sat, 4 May 2002 13:54:01 -0400
Date: Sat, 4 May 2002 13:54:01 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Oliver Pitzeier <o.pitzeier@uptime.at>
cc: "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: Another problem with Alpha and 2.5.13
In-Reply-To: <000f01c1f393$ae6e2280$1201a8c0@pitzeier.priv.at>
Message-ID: <Pine.GSO.4.21.0205041353400.23892-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 4 May 2002, Oliver Pitzeier wrote:

> Hi volks!
> 
> Here the problem
> raid5.c: In function `raid5_diskop':

raid5 is yet to be ported to bio.

