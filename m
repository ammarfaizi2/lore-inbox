Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265459AbSKAAj1>; Thu, 31 Oct 2002 19:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265472AbSKAAj0>; Thu, 31 Oct 2002 19:39:26 -0500
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:36810 "EHLO
	snipe.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S265459AbSKAAjW>; Thu, 31 Oct 2002 19:39:22 -0500
Date: Thu, 31 Oct 2002 17:38:56 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Andreas Schuldei <andreas@schuldei.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] Re: [BK console] console updates.
In-Reply-To: <20021030221231.GB30877@lukas>
Message-ID: <Pine.LNX.4.33.0210311738260.2733-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 3) Multi-desktop systems. Already done this. The current code in BK
> >    doesn't support this just yet as I have a few bug to beat out for
> >    single headed systems. It will take about one more week to get this
> >    ready.
>
> this is something i know several people are interested in. and it
> does not touch core code to add, does it?
>
> This is my personal-favorit-must-go-in-above-all-else-feature.

Just the VT console code. It does effect the console display drivers tho.



