Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318036AbSHKJ6h>; Sun, 11 Aug 2002 05:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318173AbSHKJ6h>; Sun, 11 Aug 2002 05:58:37 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:18928 "EHLO
	pimout3-int.prodigy.net") by vger.kernel.org with ESMTP
	id <S318036AbSHKJ6h>; Sun, 11 Aug 2002 05:58:37 -0400
Message-Id: <200208111002.g7BA2Ga64100@pimout3-int.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: "H. Peter Anvin" <hpa@zytor.com>,
       "Albert D. Cahalan" <acahalan@cs.uml.edu>
Subject: Re: klibc development release
Date: Sun, 11 Aug 2002 01:02:11 -0400
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
References: <200208092016.g79KGVk87834@saturn.cs.uml.edu> <3D542482.2080109@zytor.com>
In-Reply-To: <3D542482.2080109@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 August 2002 04:22 pm, H. Peter Anvin wrote:
> Albert D. Cahalan wrote:
> >>klibc is a tiny C library subset intended to be integrated into the
> >>kernel source tree and being used for initramfs stuff.  Thus,
> >>initramfs+rootfs can be used to move things that are currently in
> >>kernel space, such as ip autoconfiguration or nfsroot (in fact,
> >>mounting root in general) into user space.
> >
> > Could I link 4-clause BSD source against this?
> > (the GPL is incompatible with the 4-clause BSD license)
>
> I'm planning to release this under a BSD-like license, such as 3-clause
> BSD, MIT or the X license.  I'm still looking at each of those.

What's wrong with LGPL?  I thought libraries were what it was originally 
intended for.  (Is 4 clause BSD incompatable with LGPL?)

Yeah, I know stallman's decided to hate.  I'm sure he'd be happy to know that 
stance encourages stuff to be released BSD-ish instead. :)

Rob
