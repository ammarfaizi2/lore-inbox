Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbVI1U4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbVI1U4z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 16:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbVI1U4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 16:56:55 -0400
Received: from magic.adaptec.com ([216.52.22.17]:39315 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1750809AbVI1U4y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 16:56:54 -0400
Message-ID: <433B0374.4090100@adaptec.com>
Date: Wed, 28 Sep 2005 16:56:20 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: Patrick Mansfield <patmans@us.ibm.com>, Luben Tuikov <ltuikov@yahoo.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <Pine.LNX.4.10.10509281227570.19896-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10509281227570.19896-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Sep 2005 20:56:29.0282 (UTC) FILETIME=[192E8420:01C5C46F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/28/05 15:45, Andre Hedrick wrote:
> Hi Patrick,
> 
> You have hit on one of the key word of my downfall.
> 
> Specifications!!!
> 
> I believe in them and they are the inflexable state machine which all OSes
> are required to address.

Me too.  I live and breathe by them.

> I am for following the rules of the spec, and will bet Linus would now
> agree more so than before.

Me too.

An interesting thing which "the community" would appreciate is
that M$ has aggressively started to "go by the spec" as far
as SCSI is concerned.

Ding-ding!

> The problem is SCSI is a strange beast without
> a formal FSM.  It is more of a BusPhase psuedo stated transport.  It is

Oh, no, no, no!  So much has changed Andre.

Just take a look at SAM, and I'm sure that you'll appreciate the object
oriented design, the abstractions, etc.  Really!

Recently all new protocols follow _explicit_ state machine definitions
at each layer they define, and how it interacts with the layer
above and below again by FSMs.  It's all a good thing.

> Luben, I have a vested interest in seeing SAS run via SCSI.  So this means
> you have one ex-demi-god from the world of maintainers looking to pull you
> have towards the current path and open to ideas and willing to back a
> better design and push it.

Ok, thanks Andre.  Much appreciated.

You are the first person to back me up _publicly_.  Now if we
can find a person from "the community" to do that, and get all
the other people who've written me _privately_, we'd be in
good shape.

	Luben
P.S. Not sure if you have seen this link:
http://linux.adaptec.com/sas/


