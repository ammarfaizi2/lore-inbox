Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270029AbUJTLvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270029AbUJTLvx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 07:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270032AbUJTLtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 07:49:10 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:30882 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S269975AbUJTLqY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 07:46:24 -0400
Message-Id: <200410200115.i9K1F1BH019179@laptop11.inf.utfsm.cl>
To: "Jeff V. Merkey" <jmerkey@drdos.com>
cc: Dax Kelson <dax@gurulabs.com>, Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.9 and GPL Buyout 
In-Reply-To: Message from "Jeff V. Merkey" <jmerkey@drdos.com> 
   of "Tue, 19 Oct 2004 14:09:28 MDT." <41757478.4090402@drdos.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Tue, 19 Oct 2004 22:15:01 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeff V. Merkey" <jmerkey@drdos.com> said:
> Dax Kelson wrote:
> >>JFS, XFS, All SMP support in Linux, and RCU.

> And Numa also.

> >This isn't SCO code. This goes back to SCO's claims of "control rights"
> >over any source code that has been in the same room as UNIX code.
> >
> >These "control rights" depend on SCOs interpretation of what a 
> >derivative work is. This is a contractual dispute, an attempt of SCO to
> >reframe what a derivative work is and a big up hill battle for SCO as
> >virtually all the parties of original contracts have in their
> >declarations not supported SCO claims of "control rights".
> >
> >Stephen D. Vuksanovich, Scott Nelson, Richard A. McDonough III, Robert
> >C. Swanson, Ira Kistenberg, David Frasure, and Geoffrey D. Green.
> >
> >Four of them are (or were at relevant time periods) AT&T employees.
> >
> >See: http://www.groklaw.net/article.php?story=20041007032319488
> >
> >Besides the declarations, there is other items that don't back SCO
> >"control rights" claims such as the $echo newletter, and amendment X to
> >the contract.

> No.  They seem to have some factual concrete evidence IP covered under
> Employee agreements was used and subsequently converted into Linux,

If they have this, why don't they show the evidence? It has been more than
a year and a half, and no shred of anything even remotely resembling
evidence has shown up. To me, this says clearly that there is none (I for
one would not go around spending a few millions of dollars a month just for
fun, if I could stop the bleeding by just showing what I will have to show
anyway later on).

>                                                                     and
> they are very confident of this.

That is for sure. But they have nothing more than that confidence.

>                                   From a cursory viewpoint, it looks
> valid.

Look closer.

>         I think they have a case (having been sued and nailed for the
> same type of thing by Novell).  It's better to remove these code areas
> and make the vendors maintain them as separate patches not in the tree,
> like what happened to intermezzo.

That is complete madness.

>                                    It's low impact for Linux and the
> other vendors.

Right. SMP, NUMA, filesystems are "low impact".

> XFS, JFS and NUMA are easy ones.

If you don't use them, that is.

> RCU and NUMA are not.  Hey, Novell just handed over their patent
> portfolio to Linux, use their patents for SMP and RCU.  These areas are
> not trivial to dump out of the kernel.  If Linux did dump the infringing
> FS's, it would be a good faith effort to limit SCO's claims.

Linux (Linus et al) has done more than a good-faith effort to remove any
infringing code: They have repeatedly asked for details on what is
illegally in the kernel (and why), to remove it ASAP. No answer worthy of
that name. Likewise, the kernel code has been compared to SysV and other
variants (by people with access to the relevant sources), and nothing fishy
has shown up to here AFAIK.

> SMP and RCU look a little tougher to defend.  I remember a Brainshare
> session at SLC where the unixware guys were disclosing this stuff in
> public sessions.  Perhaps Novell could go back and publish those
> Brainshare slides on their website.  So much for claiming SMP and RCU are
> not in the public domain.

AFAIU, RCU is patented (now IBM holds it). It is certainly not in the
public domain.

> Dump the FS's and NUMA guys.  Then you are nearly there for being 
> squeaky clean.

Better just dump it all. Or start off a *BSD variant, where there is _no_
SCOX complications, and no need to shell out a few hundred millions to get
the relevant rights (yes, that is what they are worth; the 50K offer is
completely ridiculous). Note that just a few people declining your offer
makes it moot, and I know for a fact that many here on LKML will pass such
an offer.

Why don't you go trolling elsewhere?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
