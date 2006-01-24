Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbWAXPtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbWAXPtG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 10:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030359AbWAXPtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 10:49:05 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45528 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030193AbWAXPtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 10:49:04 -0500
Subject: Re: GPL V3 and Linux
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ian Kester-Haney <ikesterhaney@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <441e43c90601231755qaddb557r7f102d9c1f79ad5@mail.gmail.com>
References: <200601212043.k0LKhG4w003290@laptop11.inf.utfsm.cl>
	 <Pine.LNX.4.61.0601231703170.13590@chaos.analogic.com>
	 <87ek2y8n1f.fsf@basilikum.skogtun.org>
	 <441e43c90601231755qaddb557r7f102d9c1f79ad5@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 24 Jan 2006 15:49:22 +0000
Message-Id: <1138117763.14675.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-01-23 at 19:55 -0600, Ian Kester-Haney wrote:
> Linux shouldn;t move to the GPL3 for the very reason that the DRM
> restrictions would make linux incompatible with soon to be released

The DRM restrictions mostly only restate some of the less clear effects
of the GPL. The GPL v2 already requires all the keys etc since it
requires the scripts to build. It just makes it clearer.

> displays.  Also Nvidia and such would not be  able to make binary
> drivers available.

The GPL doesn't permit them to anyway. If they are legal then it is
because they are not derivative works which forms an implicit barrier in
copyright law. Essentially copyright law limits itself to works based on
other works. So as an author of a book I can say "You may not copy this
book" but I cannot (in copyright enforced agreement) say "You may not
write a book on this subject if you read mine", only to control works
based upon mine in a material way (which is what "derivative work" is
all about).

That also means for example that a GPL OS running a non-derivative
application has no power to forbid that application from using DRM
itself. 

Now there is a case where it get much messier - GPL with exceptions/LGPL
being the clear one. A glibc that prohibited linking with DRM using code
would raise much more complicated problems, but that is for the
glibc/FSF list to argue over and does need addressing sensibly.


>      The GNU/Linux community needs to work with the MPAA, RIAA and
> other DRM players and work to support basic restrictions on copying
> content while preserving the Creator/Companies right to sustain their
> works.

What on earth makes you think those bodies want creators to have any
rights. You've obviously never watched creators and the "industry"
fighting each other. Anyway fighting DRM is actually helping even the
music "industry"  if H. Valarian's analysis is correct.

Free Software is about -freedom- that means the freedom to do things
like play music you own the rights to play and the freedom to distribute
music you have the right to distribute. The dream of big music industry
is mandatory DRM where there is no way for an artist to escape their
clutches and publish music without them getting a very large cut of, if
not all the profits.

Much of the big music industry today is like vanity publishing, they
sign you up, bill you for the costs of making the recordings, screw you
on royalty deals then charge you the remainder the royalties didn't
cover.

So why should we work with the RIAA members (especially as there is good
evidence to suggest that one of them stole GPL code for a proprietary
DRM system) ?

Free means that everyone must be able to use Linux

Alan

