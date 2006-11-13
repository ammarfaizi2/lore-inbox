Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755322AbWKMSzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755322AbWKMSzK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 13:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755321AbWKMSzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 13:55:10 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:42137 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932792AbWKMSzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 13:55:08 -0500
Date: Mon, 13 Nov 2006 18:55:06 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] fbmem: is bootup logo broken for monochrome
 LCD ?
In-Reply-To: <cda58cb80611130631v1d560a2chcfcee904f6be317d@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0611131853250.2366@pentafluge.infradead.org>
References: <45535C08.5020607@innova-card.com> 
 <Pine.LNX.4.64.0611122138030.9472@pentafluge.infradead.org> 
 <cda58cb80611130153n60579de0w2ebb59b050595b3b@mail.gmail.com> 
 <Pine.LNX.4.64.0611131415270.25397@pentafluge.infradead.org>
 <cda58cb80611130631v1d560a2chcfcee904f6be317d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > Does this suppose to fix this issue I encountered:
> > >
> > > http://marc.theaimsgroup.com/?l=linux-kernel&m=116315548626875&w=2
> > 
> > This should fix the problems you reported. I tested this patch on a big
> > endian and little endian framebuffer on a little endian machine.
> > 
> 
> Something I'm still missing hope you can shed some light there. Why
> does the current code work on Rafael's machine (little endian one
> using vesa driver) but not on mine which is a little endian one as
> well ?

Both of you are using vesafb? 
