Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266851AbSLDDMN>; Tue, 3 Dec 2002 22:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266852AbSLDDMN>; Tue, 3 Dec 2002 22:12:13 -0500
Received: from louise.pinerecords.com ([212.71.160.16]:63249 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S266851AbSLDDMM>; Tue, 3 Dec 2002 22:12:12 -0500
Date: Wed, 4 Dec 2002 04:19:19 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: James Simmons <jsimmons@infradead.org>
Cc: Antonino Daplas <adaplas@pol.net>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] FBDev: vga16fb port
Message-ID: <20021204031919.GA11553@louise.pinerecords.com>
References: <1038930464.11426.1.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.33.0212031401440.10097-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0212031401440.10097-100000@maxwell.earthlink.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > I question whether thats something that belongs anywhere near the
> > kernel. Ben Pfaff wrote a fine library for vga16 hackery (BOGL) and it
> > combines very nicely with the fb driver.
> 
> Out of curiousity where is this library.

http://packages.qa.debian.org/b/bogl.html
http://http.us.debian.org/debian/pool/main/b/bogl/bogl_0.1.10-3.tar.gz

-- 
Tomas Szepe <szepe@pinerecords.com>
