Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262842AbSJLJon>; Sat, 12 Oct 2002 05:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262862AbSJLJon>; Sat, 12 Oct 2002 05:44:43 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:15634 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S262842AbSJLJom>; Sat, 12 Oct 2002 05:44:42 -0400
Date: Sat, 12 Oct 2002 11:50:26 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.42
Message-ID: <20021012095026.GC28537@merlin.emma.line.org>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0210112134160.7166-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210112134160.7166-100000@penguin.transmeta.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Oct 2002, Linus Torvalds wrote:

> PS: NOTE - I'm not going to merge either EVMS or LVM2 right now as things
> stand.  I'm not using any kind of volume management personally, so I just
> don't have the background or inclination to walk through the patches and
> make that kind of decision. My non-scientific opinion is that it looks 
> like the EVMS code is going to be merged, but ..
> 
> Alan, Jens, Christoph, others - this is going to be an area where I need
> input from people I know, and preferably also help merging. I've been 
> happy to see the EVMS patches being discussed on linux-kernel, and I just 
> wanted to let people know that this needs outside help.

A user's input, of not nearly as much weight as of the input you
suggested, and totally unencumbered by technical details:

EVMS has been much more present to interested parties than LVM2. If --
as a user -- I was to choose either one RIGHT NOW (i. e. with a gun
against a head, a boss telling me 'I want a decision in 30 minutes', you
name it), I'd go for EVMS.

Not for the names behind, the LVM2 and the EVMS teams both have their
reputation, and from my POV, they are equally good.

Not for technical reasons either, because I just cannot judge on this
area.

But because EVMS just looks much less like a construction site than
dm2/LVM2 does.

If there was something about integrating dm2, I'd not be surprised if
EVMS used it or wrapped it up or something. It also usurps LVM1.

Just my two Euro cents.
