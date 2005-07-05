Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbVGEHOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVGEHOp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 03:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbVGEHOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 03:14:44 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:6853 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261405AbVGEHNk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 03:13:40 -0400
Date: Tue, 5 Jul 2005 09:14:54 +0200
From: Jens Axboe <axboe@suse.de>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: Pavel Machek <pavel@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
       Lenz Grimmer <lenz@grimmer.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Dave Hansen <dave@sr71.net>, Henrik Brix Andersen <brix@gentoo.org>,
       hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
Subject: Re: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested? (Accelerometer))
Message-ID: <20050705071449.GV1444@suse.de>
References: <9a8748490507031832546f383a@mail.gmail.com> <42C8D06C.2020608@grimmer.com> <20050704061713.GA1444@suse.de> <42C8C978.4030409@linuxwireless.org> <20050704063741.GC1444@suse.de> <1120461401.3174.10.camel@laptopd505.fenrus.org> <20050704072231.GG1444@suse.de> <20050704130336.GB3449@openzaurus.ucw.cz> <42C9A562.5090900@linuxwireless.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C9A562.5090900@linuxwireless.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04 2005, Alejandro Bonilla wrote:
> Pavel Machek wrote:
> 
> >
> >Actually, "spin disk down and keep it down" would be nice for other
> >reasons. Taking computer for a jog playing mp3s from ramdisk is
> >something I'd like to do...
> >				Pavel
> > 
> >
> This is exactly what I wanted to do. hdparm suspend which would send 
> things to cache or buffer and then copy or get files only when needed. I 
> just hope is fast enough, but we could trigger this with tilting or 
> vibration and then something heavier when we find a free fall.
> 
> This driver does not exactly has to behave like Windows. It can be 
> better. We always make things better.

As Lenz already suggested, you both pretty much seem to be describing
laptop mode. See the documentation.

-- 
Jens Axboe

