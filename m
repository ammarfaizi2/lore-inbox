Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265351AbSJRRb6>; Fri, 18 Oct 2002 13:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265348AbSJRRax>; Fri, 18 Oct 2002 13:30:53 -0400
Received: from gull.mail.pas.earthlink.net ([207.217.120.84]:50381 "EHLO
	gull.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S265345AbSJRRaS>; Fri, 18 Oct 2002 13:30:18 -0400
Date: Fri, 18 Oct 2002 10:29:47 -0700 (PDT)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] fbdev changes.
In-Reply-To: <1034628378.1143.507.camel@tibook>
Message-ID: <Pine.LNX.4.33.0210181028520.10832-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Wouldn't that complicate merges between the kernel and DRI CVS? At any
> rate, I think discussion related to the DRI should take place on
> dri-devel.

Okay the idea of mixing the drivers together was rejected. SO I just moved
the entire directory to drivers/video instead. People didn't seem to have
problem with that.

