Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262224AbTBERGu>; Wed, 5 Feb 2003 12:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262258AbTBERGt>; Wed, 5 Feb 2003 12:06:49 -0500
Received: from crack.them.org ([65.125.64.184]:51935 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S262224AbTBERGs>;
	Wed, 5 Feb 2003 12:06:48 -0500
Date: Wed, 5 Feb 2003 12:16:13 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Nilmoni Deb <ndeb@ece.cmu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Monta Vista software license terms
Message-ID: <20030205171613.GB14909@nevyn.them.org>
Mail-Followup-To: Nilmoni Deb <ndeb@ece.cmu.edu>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.3.96L.1030205115551.1886A-100000@ndeb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96L.1030205115551.1886A-100000@ndeb.net>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Ooh, another CMU person.  Hi.]

Disclaimer: this is not legal advice, and I do not speak for my
employer.  I'm also not responsible for policies, so please don't vent
at me or I'll stop trying to be helpful.

On Wed, Feb 05, 2003 at 11:58:23AM +0000, Nilmoni Deb wrote:
> 
> This is about Monta Vista Software, a company that develops software for
> embedded platforms, based on the Linux kernel and (possibly) other GPL
> software.
> 
> In its official FAQ page, http://www.mvista.com/products/faq.html#q9 , it
> says:
> 
> "A: The GNU General Public License (GPL) is very specific about the 
> obligations imposed on developers leveraging Open Source. If you 
> deploy/redistribute program binaries derived from source code licensed  
> under the GPL, you must
> 
> 
>  Supply the source code to derived GPL code or Make an offer (good for 3
> years) to supply the source code
>  
>  Retain all licensing / header information, copyright notices, etc. in
> those sources
>  
>  Redistribute the text of the GPL with the binaries and/or source code
>  
>  Note that your obligation is strictly to the recipients of binaries
> (i.e., your customers). You have no responsibility to the "community" at
> large."
> 
> 
> 
> 
> 
> 	Its the last sentence that is of concern. Does this mean no 3rd
> party (who is not a customer) can get the GPL source code part of their
> products ? Seems like a GPL violation of clause 3b in
> http://www.gnu.org/licenses/gpl.html .

I suggest you read clause 3b again:
   3. You may copy and distribute the Program (or a work based on it, under Section 2) in object
   code or executable form under the terms of Sections 1 and 2 above provided that you also do
   one of the following:
     * b) Accompany it with a written offer, valid for at least three years, to give any third
       party, for a charge no more than your cost of physically performing source distribution,
       a complete machine-readable copy of the corresponding source code, to be distributed
       under the terms of Sections 1 and 2 above on a medium customarily used for software
       interchange; or,

If you don't distribute a binary to someone, then you are under no
obligation to distribute source to them.  The GPL's always worked that
way.  One can't restrict what one's customers do with the source, but
that doesn't oblige one to give it away.

> In addition:
> 
> 1. There is no linux kernel source in ftp://ftp.mvista.com/

Nor any reason it should be there.

> 2. The download page http://www.mvista.com/previewkit/index.html does not
> claim to offer any source code at all.

I'm told that the preview kits do include kernel source, although I
haven't checked for myself in a couple of months.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
