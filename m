Return-Path: <linux-kernel-owner+w=401wt.eu-S932731AbXAAUNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932731AbXAAUNQ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 15:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932796AbXAAUNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 15:13:16 -0500
Received: from smtp.osdl.org ([65.172.181.25]:34017 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932731AbXAAUNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 15:13:15 -0500
Date: Mon, 1 Jan 2007 12:13:08 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alessandro Suardi <alessandro.suardi@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alan@lxorguk.ukuu.org.uk
Subject: Re: Happy New Year (and v2.6.20-rc3 released)
In-Reply-To: <5a4c581d0701010528y3ba05247nc39f2ef096f84afa@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0701011209140.4473@woody.osdl.org>
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org>
 <5a4c581d0701010528y3ba05247nc39f2ef096f84afa@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff, 
 what was the resolution to this one? Just revert the offending commit, or 
what?

We're about five weeks into the 2.6.20-rc series. I was hoping for a 
two-month release rather than the usual dragged-out three months, so I'd 
like to get these regressions to be actively fixed. By forcible reverts if 
that is what it takes.

		Linus

On Mon, 1 Jan 2007, Alessandro Suardi wrote:
> 
> Right ! And this one is still broken in -rc3:
> 
> Subject    : kernel panics on boot (libata-sff)
> References : http://lkml.org/lkml/2006/12/3/99
>            http://lkml.org/lkml/2006/12/14/153
>            http://lkml.org/lkml/2006/12/24/33
> Submitter  : Alessandro Suardi <alessandro.suardi@gmail.com>
> Caused-By  : Alan Cox <alan@lxorguk.ukuu.org.uk>
>            commit 368c73d4f689dae0807d0a2aa74c61fd2b9b075f
> Handled-By : Alan Cox <alan@lxorguk.ukuu.org.uk>
> Status     : people are working on a fix
> 
> Happy 2007 everyone,
> 
> --alessandro
> 
> "...when I get it, I _get_ it"
> 
>     (Lara Eidemiller)
> 
