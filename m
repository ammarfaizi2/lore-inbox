Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265851AbUA1GOD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 01:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265860AbUA1GOC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 01:14:02 -0500
Received: from kiuru.kpnet.fi ([193.184.122.21]:36502 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S265851AbUA1GOA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 01:14:00 -0500
Date: Wed, 28 Jan 2004 08:13:36 +0200 (EET)
From: =?iso-8859-1?Q?Markus_H=E4stbacka?= <midian@ihme.org>
X-X-Sender: midian@midi
To: David Weinehall <david@southpole.se>
cc: Coywolf Qi Hunt <coywolf@lovecn.org>,
       Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [2.0.40-rc8] Works well
In-Reply-To: <20040128033755.GC16675@khan.acc.umu.se>
Message-ID: <Pine.LNX.4.44.0401280809470.20944-100000@midi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jan 2004, David Weinehall wrote:

> On Wed, Jan 28, 2004 at 03:28:30AM +0000, Coywolf Qi Hunt wrote:
> ...
> > Recently I just have such an idea that is to port the 2.0.39 to let it
> > be compiled with my gcc 2.95.4 or any
> > other latest gcc. At the same time,  also make it remain compliant to
> > gcc 2.7.2.1. ( I can't find 2.7.2.1, only 2.7.2.3
> > on the ftp)  Is this work worth while?
>
> Well, for sure it's quite a demanding task, since, if I remember
> correctly, the module-code uses some nasty internal gcc-knowledge to
> generate code, that simply doesn't work with later versions of gcc.
> It might be that I remember this incorrectly though.
>
only the module-code? :)
> It would be interesting, yes, but only if it can be proved to some
> degree that no new bugs are introduced.
>
That would probably be impossible to do without introducing any bugs..
> My aim for 2.0.41 is to make it a cleanup-release; remove warnings, tidy
> up a little source-code mess, kill dead code, fix typos etc.
>
Sounds great, a bit amazing that 2.0 is alive again :)

	Markus

