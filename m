Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289027AbSAFUes>; Sun, 6 Jan 2002 15:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289028AbSAFUej>; Sun, 6 Jan 2002 15:34:39 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:53923 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S289027AbSAFUe3>; Sun, 6 Jan 2002 15:34:29 -0500
Date: Sun, 6 Jan 2002 13:27:16 -0700
Message-Id: <200201062027.g06KRGE16491@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@zip.com.au (Andrew Morton), ivan@cyclades.com (Ivan Passos),
        linux-kernel@vger.kernel.org
Subject: Re: Serial Driver Name Question (kernels 2.4.x)
In-Reply-To: <E16NK1Q-0006Tc-00@the-village.bc.nu>
In-Reply-To: <200201062012.g06KCIu16158@vindaloo.ras.ucalgary.ca>
	<E16NK1Q-0006Tc-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> > > Oh dear.  Why cannot devfs expand the minor part itself?
> > 
> > Do you mean why devfs can't do it, or do you mean why tty_name() can't
> > do it? As I said, tty_name() used to do it, but there was some problem
> > with that.
> 
> What was the problem ?

Dunno. Lost in the mists of time, when the world was young.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
