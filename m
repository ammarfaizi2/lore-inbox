Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131455AbQLQUm4>; Sun, 17 Dec 2000 15:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131584AbQLQUmr>; Sun, 17 Dec 2000 15:42:47 -0500
Received: from ferret.phonewave.net ([208.138.51.183]:65293 "EHLO
	tarot.mentasm.org") by vger.kernel.org with ESMTP
	id <S131455AbQLQUmg>; Sun, 17 Dec 2000 15:42:36 -0500
Date: Sun, 17 Dec 2000 12:08:35 -0800 (PST)
From: ferret@phonewave.net
To: Peter Samuelson <peter@cadcamlab.org>
cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Petr Vandrovec <VANDROVE@vc.cvut.cz>,
        Dana Lacoste <dana.lacoste@peregrine.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: Linus's include file strategy redux
In-Reply-To: <14908.29798.413845.663365@wire.cadcamlab.org>
Message-ID: <Pine.LNX.3.96.1001217120047.29402A-100000@tarot.mentasm.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 17 Dec 2000, Peter Samuelson wrote:

> 
> [ferret@phonewave.net <ferret@phonewave.net>]
> > I have not moved or deleted a tree. I do not HAVE a kernel tree in
> > the first place. Therefore, nothing for the symlink to point to when
> > I install the kernel.
> 
> If this is not the machine you compile your kernels on, why are you
> compiling your external modules on it?

One last question: WHY is the kernel's top-level Makefile handling this
symlink?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
