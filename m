Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263253AbTDCDrm>; Wed, 2 Apr 2003 22:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263257AbTDCDrm>; Wed, 2 Apr 2003 22:47:42 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:21778 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263253AbTDCDrl>; Wed, 2 Apr 2003 22:47:41 -0500
Date: Thu, 3 Apr 2003 04:59:06 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Joshua Kwan <joshk@triplehelix.org>
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [REPRODUCABLE BUGS] Linux 2.5.66
In-Reply-To: <20030403010217.GA23813@triplehelix.org>
Message-ID: <Pine.LNX.4.44.0304030458190.3919-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > The junk quickly scrolls off into the sunset and has no adverse
> > > effects on the following boot messages.
> > 
> > I have a feeling take_over_console needs to run a vc_resize_console.
> 
> Actually, whatever was in the latest fbdev.diff.gz fixed it.
> To be more precise, whichever fbdev.diff was in 2.5.65-mm1 and onwards.
> 
> The logo is still missing in action, I'm trying to debug this. Is anyone 
> noticing the same thing?

The latest patch should fix that. I'm glad to here of the success. So far 
so good on the latest changes.



