Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267566AbTBDXXg>; Tue, 4 Feb 2003 18:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267562AbTBDXXg>; Tue, 4 Feb 2003 18:23:36 -0500
Received: from dp.samba.org ([66.70.73.150]:9893 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267566AbTBDXXf>;
	Tue, 4 Feb 2003 18:23:35 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org, greg@kroah.com, jgarzik@pobox.com
Subject: Re: [PATCH] Module alias and device table support. 
In-reply-to: Your message of "Tue, 04 Feb 2003 09:05:46 BST."
             <200302040805.h1485lhI002898@eeyore.valparaiso.cl> 
Date: Tue, 04 Feb 2003 19:51:23 +1100
Message-Id: <20030204233310.AD6AF2C04E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200302040805.h1485lhI002898@eeyore.valparaiso.cl> you write:
> > It's undefined for the "in the config file case" (they curently *do*
> > override, but that's an implementation detail).  It'd be clearer to
> > explicitly say "you can't override module names with "alias", use
> > "install" instead, IMHO.
> 
> Urgh. What is "alias" then for? It has been used for ages as a way of "call
> module foo by name bar, possibly with this further arguments". Why change
> that gratuitously?

I'm going to stop here, since I don't think you understand what I am
proposing, nor how the current system works: this makes is extremely
difficult to describe changes, and time consuming.

Sorry,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
