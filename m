Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262346AbTCIB5I>; Sat, 8 Mar 2003 20:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262353AbTCIB5I>; Sat, 8 Mar 2003 20:57:08 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:13189 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S262346AbTCIB5H>;
	Sat, 8 Mar 2003 20:57:07 -0500
Message-Id: <200303090206.h2926a8W004185@eeyore.valparaiso.cl>
To: Pavel Machek <pavel@suse.cz>
cc: Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone 
In-Reply-To: Your message of "Fri, 07 Mar 2003 20:08:48 BST."
             <20030307190848.GB21023@atrey.karlin.mff.cuni.cz> 
Date: Sat, 08 Mar 2003 23:06:36 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> said:

[...]

> So, basically, if branch was killed and recreated after each merge
> from mainline, problem would be solved, right?

Who is branch, who is mainline? The branch owner _will_ be pissed off if
his head version changes each time he syncronizes. What if mainline dies,
and the official line moves to one of the branches? What happens when there
aren't just two, but a dozen developers swizzling individual csets from
each other (not necesarily just resyncing with each other)? If said
developers also apply random patches from a common mailing list?

This is _much_ harder than it looks on the surface.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
