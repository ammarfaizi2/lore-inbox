Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262786AbSJEWeT>; Sat, 5 Oct 2002 18:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262789AbSJEWeT>; Sat, 5 Oct 2002 18:34:19 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:59291 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S262786AbSJEWeS>; Sat, 5 Oct 2002 18:34:18 -0400
Date: Sat, 5 Oct 2002 17:39:52 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Peter Osterlund <petero2@telia.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.40 - and a feature freeze reminder
In-Reply-To: <m2ptuo8qre.fsf@p4.localdomain>
Message-ID: <Pine.LNX.4.44.0210051739310.13557-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Oct 2002, Peter Osterlund wrote:

> Linus Torvalds <torvalds@transmeta.com> writes:
> 
> > Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
> >   o kbuild: Make KBUILD_VERBOSE=0 work better under emacs
> 
> This change has the unfortunate side effect that compilation doesn't
> stop after a compile error if I run make without arguments. I observed
> this when enabling debugging in yenta.c. Building with "make
> KBUILD_VERBOSE=1" does stop after the error.

Right. Fixed in Linus' bk tree.

--Kai


