Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314149AbSFXPrx>; Mon, 24 Jun 2002 11:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314277AbSFXPrw>; Mon, 24 Jun 2002 11:47:52 -0400
Received: from ftp.realnet.co.sz ([196.28.7.3]:31134 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S314149AbSFXPrv>; Mon, 24 Jun 2002 11:47:51 -0400
Date: Mon, 24 Jun 2002 17:18:33 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: "Alexandre P. Nunes" <alex@PolesApart.wox.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.19-pre10-ac2 bug in page_alloc.c:131
In-Reply-To: <3D173578.5080205@PolesApart.wox.org>
Message-ID: <Pine.LNX.4.44.0206241715080.2033-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jun 2002, Alexandre P. Nunes wrote:

> Maybe I got it the wrong way, but it seems to me that from your point of 
> view, as long as proprietary driver is in use, it's not anyone else 
> problem but to the vendor, even if the bug could happen to be in the 
> kernel, is that right? If so, everyone else in this list who could try 
> to fix this (again assuming it could be something related to the kernel 
> and not to the proprietary driver) necessarily share your oppinion? (I'm 
> not flaming in here, just trying to get the path).

This particular one has cropped up a multitude of times, i can assure you 
that you're not the first. Try searching the archives for 
__free_pages_ok, nvidia and a few other keywords. I've seen that 
particular bug first hand and its definitely the work of the nvidia 
driver. Try their 2314 driver, i can't recall seeing it with that 
particular version.

Cheers,
	Zwane

-- 
http://function.linuxpower.ca
		

