Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263760AbTBESh5>; Wed, 5 Feb 2003 13:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263977AbTBESh4>; Wed, 5 Feb 2003 13:37:56 -0500
Received: from ECE.CMU.EDU ([128.2.136.200]:24029 "EHLO ece.cmu.edu")
	by vger.kernel.org with ESMTP id <S263760AbTBEShq>;
	Wed, 5 Feb 2003 13:37:46 -0500
Date: Wed, 5 Feb 2003 13:47:10 -0500 (EST)
From: Nilmoni Deb <ndeb@ece.cmu.edu>
Reply-To: Nilmoni Deb <ndeb@ece.cmu.edu>
To: Daniel Jacobowitz <dan@debian.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Monta Vista software license terms
In-Reply-To: <20030205171613.GB14909@nevyn.them.org>
Message-ID: <Pine.LNX.3.96L.1030205132625.5144W-100000@frodo.ece.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 5 Feb 2003, Daniel Jacobowitz wrote:

> [Ooh, another CMU person.  Hi.]

Is CMU in a black list ? Never mind ....

> 
> Disclaimer: this is not legal advice, and I do not speak for my
> employer.  I'm also not responsible for policies, so please don't vent
> at me or I'll stop trying to be helpful.

as u wish

> 
> On Wed, Feb 05, 2003 at 11:58:23AM +0000, Nilmoni Deb wrote:
> > 
> > This is about Monta Vista Software, a company that develops software for
> > embedded platforms, based on the Linux kernel and (possibly) other GPL
> > software.
> > 
> > In its official FAQ page, http://www.mvista.com/products/faq.html#q9 , it
> > says:
> > 
> > "A: The GNU General Public License (GPL) is very specific about the 
> > obligations imposed on developers leveraging Open Source. If you 
> > deploy/redistribute program binaries derived from source code licensed  
> > under the GPL, you must
> > 
> > 
> >  Supply the source code to derived GPL code or Make an offer (good for 3
> > years) to supply the source code
> >  
> >  Retain all licensing / header information, copyright notices, etc. in
> > those sources
> >  
> >  Redistribute the text of the GPL with the binaries and/or source code
> >  
> >  Note that your obligation is strictly to the recipients of binaries
> > (i.e., your customers). You have no responsibility to the "community" at
> > large."
> > 
> > 
> > 
> > 
> > 
> > 	Its the last sentence that is of concern. Does this mean no 3rd
> > party (who is not a customer) can get the GPL source code part of their
> > products ? Seems like a GPL violation of clause 3b in
> > http://www.gnu.org/licenses/gpl.html .
> 
> I suggest you read clause 3b again:
>    3. You may copy and distribute the Program (or a work based on it, under Section 2) in object
>    code or executable form under the terms of Sections 1 and 2 above provided that you also do
>    one of the following:
>      * b) Accompany it with a written offer, valid for at least three years, to give any third
>        party, for a charge no more than your cost of physically performing source distribution,
>        a complete machine-readable copy of the corresponding source code, to be distributed
>        under the terms of Sections 1 and 2 above on a medium customarily used for software
>        interchange; or,
> 
> If you don't distribute a binary to someone, then you are under no
> obligation to distribute source to them.  The GPL's always worked that
> way.  One can't restrict what one's customers do with the source, but
> that doesn't oblige one to give it away.

Actually, my question has been answered and the answer is: if the vendor
complies with 3a, then the vendor does not have to worry about 3b anymore.

> > In addition:
> > 
> > 1. There is no linux kernel source in ftp://ftp.mvista.com/
> 
> Nor any reason it should be there.
> 
> > 2. The download page http://www.mvista.com/previewkit/index.html does not
> > claim to offer any source code at all.
> 
> I'm told that the preview kits do include kernel source, although I
> haven't checked for myself in a couple of months.
> 
> -- 
> Daniel Jacobowitz
> MontaVista Software                         Debian GNU/Linux Developer


