Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbVLDUoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbVLDUoO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 15:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbVLDUoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 15:44:14 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:21935 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id S932340AbVLDUoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 15:44:12 -0500
Message-Id: <200512041957.jB4Jv4rI021321@pincoya.inf.utfsm.cl>
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
cc: Matthias Andree <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel 
In-Reply-To: Message from "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com> 
   of "Sat, 03 Dec 2005 17:52:41 PDT." <43923DD9.8020301@wolfmountaingroup.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Sun, 04 Dec 2005 16:57:04 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff V. Merkey <jmerkey@wolfmountaingroup.com> wrote:
> Matthias Andree wrote:
> >On Sat, 03 Dec 2005, Arjan van de Ven wrote:

[...]

> These folks have nothing new to innovate here. The memory manager and
> VM gets revamped every other release.

That is a sign of movement. Sure, one can argue if it is random movement of
definite progress, but change /is/ a part of innovation.

>                                       Exports get broken, binary only
> module compatibility busted every rev of the kernel.

In-kernel API was /never/ guaranteed, so you have nothing to complain here.

>                                                      I spend weeks on
> each kernel fixing the breakage. These people don't get it,

They do get it, and have their reasons to act this way. Reasons you don't
get, it seems.

>                                                             don't care,

They do care. But not about the same thing you care about.

> and to be honest, you are wasting your time here trying to convince
> them.

It is /their/ code, with which they are free to do as they wish. If you
contribute enough, you get a say in it too; until that time, just be
grateful for what you get given freely.

>       It's never stable because they don't want it to be. This is how
> they maintain control of this code.

Licensing under GPL while "maintaining control" is a contradiction in
terms. If you don't like where the development is going, you are free to
fork it. Just the developers won't follow you, as the consensus between
them is against your wishes.

>                                     I have apps written for Windows in
> 1990 and 1998 that still run on Windows XP today.

I have programs written in the early 80s that still can be compiled and run
on Linux. And AFAIK the very first a.out binaries for Linux still work (I'd
assume that setting up the shared libraries for them is a royal pain).

I have programs by /Microsoft/ which don't run after Win98, even though
they are supposed to run on later versions. 

Besides, this backward compatibility is exactly one of the major reasons
for Windows breakage, they just can't get a clean cut from the past.

>                                                   Linux has no such
> concept of backwards compatiblity.

For user programs? Sure is.

>                                    Every company who has embraced it
> outside of hardware based solutions is dying or has died.

So?

>                                                           IBM is secretly
> forking it as we speak and using it to get out of paying for Unix
> licenses.

Could you please give some kind of evidence for this misbehaviour by IBM?

> As annoying as it is, accept it and live with it. These people have no
> sense of loyalty to you or your customers. They don't even care about
> each other.

Right. Their only loyalty is to a better kernel (system). Nothing
else. Nobody /ever/ promised anything else, in fact, they have /always/
stated that that is their only objective. You definitely haven't gotten
shafted.

[...]

> You are standing on a battlefield. Quietly fork each release, make your
> mods, post patches somewhere for the poor civilians who are "collateral
> damage" in the war with constantly busted software, and you might help
> some folks.

This is what distributions do routinely... and the current development
model is precisely to /disminish/ the cost of keeping up to date by third
parties. In that sense the kernel community /does/ care for them, just that
they don't make any promises. Take it or leave it. There are alternatives,
like the various BSD flavors. Or even Solaris, or closed Unix variants.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

