Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbUAIS2V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 13:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbUAIS2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 13:28:21 -0500
Received: from [193.138.115.2] ([193.138.115.2]:34829 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S262792AbUAIS2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 13:28:20 -0500
Date: Fri, 9 Jan 2004 19:25:18 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Jakub Jelinek <jakub@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] invalid ELF binaries can execute - better sanity
 checking
In-Reply-To: <20040109180839.GW1882@matchmail.com>
Message-ID: <Pine.LNX.4.56.0401091911080.12889@jju_lnx.backbone.dif.dk>
References: <Pine.LNX.4.56.0401090236390.11276@jju_lnx.backbone.dif.dk>
 <20040109102851.GF24876@devserv.devel.redhat.com>
 <Pine.LNX.4.56.0401091141200.12106@jju_lnx.backbone.dif.dk>
 <20040109180839.GW1882@matchmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Jan 2004, Mike Fedyk wrote:

> On Fri, Jan 09, 2004 at 11:50:53AM +0100, Jesper Juhl wrote:
> > I just wanted to get some feedback initially. The patch was a very minor
> > bit of the email I send, and probably the least important bit.
> > I wanted to get peoples reactions to the thought of adding stronger sanity
> > checks. The patch was just a minor thing - the discussion about "do we
> > want additional checks?" was the important bit.
>
> There are some patches for the elf loader from one of the big names in LKML,
> but I forgot who it was.  Maybe a search through google will bring something
> up...
>
I have been digging for patches, and I've found some that clean up various
bits in various archs, and I'll try to take all that into account in my
own modifications.


-- Jesper Juhl

