Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267280AbTBLR3E>; Wed, 12 Feb 2003 12:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267350AbTBLR3E>; Wed, 12 Feb 2003 12:29:04 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:45072 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267280AbTBLR3C>; Wed, 12 Feb 2003 12:29:02 -0500
Date: Wed, 12 Feb 2003 17:38:50 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Jos Hulzink <josh@stack.nl>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.60] : drivers/video/* compile errors
In-Reply-To: <200302102343.50581.josh@stack.nl>
Message-ID: <Pine.LNX.4.44.0302121738340.31435-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Hi,
> >
> > drivers/video/clgenfb.c doesn't compile, for hundreds of things are
> > undefined...
> >
> > seems the include/video/fbdev*.h files are missing in the ftp.kernel.org
> > 2.5.60 ?
> 
> Err.. fbcon*.h of course...
> 
> I see now they moved...
> 
> A simple grep learns me that 15 drivers use the wrong include dir

The fbdev api has changed. 

