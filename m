Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270662AbTGNSRg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 14:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270680AbTGNSRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 14:17:36 -0400
Received: from gate.crashing.org ([63.228.1.57]:22452 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S270662AbTGNSRe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 14:17:34 -0400
Date: Mon, 14 Jul 2003 13:30:16 -0500 (CDT)
From: <ajoshi@kernel.crashing.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>, benh@kernel.crashing.org
Subject: Re: radeonfb patch for 2.4.22...
In-Reply-To: <Pine.LNX.4.55L.0307141506020.8994@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.10.10307141315170.28093-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 Jul 2003, Marcelo Tosatti wrote:
> 
> On Mon, 14 Jul 2003 ajoshi@kernel.crashing.org wrote:
> 
> >
> > Hi Marcelo,
> >
> > Is there any particular reason why you decided to merge Ben H.'s radeonfb
> > update instead of the one I sent you?
> 
> I've decided to CC lkml because I think there are other people interested
> in this discussion.
> 
> I merged his version because he sent me your update (0.1.8) plus his code
> (which are useful fixes he has been working on).

Which is what the original 0.1.8 patch included, his fixes were included.

> 
> It seems things are broken now due to a missing header, but he also sent
> me that.

There was no missing header, if you see the patch I sent you (about 3
times), the header file is in there.

> 
> Do you have any objections to his fixes ?
> 

Besides the obvious version changes and difficulty maintaining a driver
where anyone seems to be able to change it in the official tree, the
objections were deteremined and fixed in the patch I sent you.

Refresh my memory as it seems things have  changed in kernel patch
submission process:

There is someone called a driver author or maintainer, this person
recieves patches for fixes from various people, he/she then compiles them
into a single patch and submits it to the kernel tree maintiner.  However
nowdays it seems the kernel tree maintainer has the descretion to accept
patches from anyone how puts up a fight, is this the case nowdays?  

If so then please let me know, so I don't waste anymore of my time on this
driver and let someone else play these silly games and maintain it.


ani

