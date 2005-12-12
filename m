Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbVLLUFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbVLLUFe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 15:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbVLLUFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 15:05:33 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:48019
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932196AbVLLUFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 15:05:32 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Ben Slusky <sluskyb@paranoiacs.org>
Subject: Re: ipw2200 [was Re: RFC: Starting a stable kernel series off the 2.6 kernel]
Date: Mon, 12 Dec 2005 14:02:43 -0600
User-Agent: KMail/1.8
Cc: Pavel Machek <pavel@ucw.cz>, Bill Davidsen <davidsen@tmr.com>,
       Mark Lord <lkml@rtr.ca>, Adrian Bunk <bunk@stusta.de>,
       David Ranson <david@unsolicited.net>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Matthias Andree <matthias.andree@gmx.de>
References: <20051203135608.GJ31395@stusta.de> <200512102330.31572.rob@landley.net> <20051212173456.GB8209@paranoiacs.org>
In-Reply-To: <20051212173456.GB8209@paranoiacs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512121402.43957.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 December 2005 11:34, Ben Slusky wrote:
> On Sat, 10 Dec 2005 23:30:30 -0600, Rob Landley wrote:
> > Query: if you tell lilo or grub that it has an initrd but feed it a
> > gzipped cpio image, will the kernel figure everything out and initialize
> > initramfs from that appropriately?
>
> Yes, I've been booting my laptop this way (using GRUB) since 2.6.7 or so.

Sigh, gotta update the docs again... :)

Do you need to compile initrd support in for this to work, or just tell 
grub/lilo to do its' thing?  (I can answer this one myself when I get around 
to setting up another test environment...)

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.
