Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbUCGTZL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 14:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262309AbUCGTZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 14:25:10 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:28062 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S261738AbUCGTZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 14:25:06 -0500
Date: Sun, 7 Mar 2004 20:25:04 +0100
From: David Weinehall <tao@acc.umu.se>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.26-pre2
Message-ID: <20040307192504.GS19111@khan.acc.umu.se>
Mail-Followup-To: Horst von Brand <vonbrand@inf.utfsm.cl>,
	Eyal Lebedinsky <eyal@eyal.emu.id.au>, linux-kernel@vger.kernel.org
References: <404AB6C7.7010803@eyal.emu.id.au> <200403071619.i27GJkOZ003480@eeyore.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403071619.i27GJkOZ003480@eeyore.valparaiso.cl>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 07, 2004 at 01:19:46PM -0300, Horst von Brand wrote:
> Eyal Lebedinsky <eyal@eyal.emu.id.au> said:
> > Marcelo Tosatti wrote:
> > > 
> > > Hi, 
> > > 
> > > Here goes -pre2 -- it contains networking updates, network drivers 
> > > updates, an XFS update, amongst others.
> >  >
> > > <jon:focalhost.com>:
> > >   o [CRYPTO]: Add ARC4 module
> > 
> > In standard C we declare all variables at the top of a function. While
> > some compilers allow extension, it is not a good idea to get used to
> > them if we want portable code.
> 
> Oh, come on. This is _kernel_ code, it won't ever be compiled with anything
> not GCC-compatible.

Ugly warts don't become any less ugly just because gcc accepts them...


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
