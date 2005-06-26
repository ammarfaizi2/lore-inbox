Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbVFZR1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbVFZR1b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 13:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVFZR1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 13:27:30 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:47046 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261496AbVFZR0q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 13:26:46 -0400
Subject: Re: reiser4 plugins
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Masover <ninja@slaphack.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Hans Reiser <reiser@namesys.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <42BCCC32.1090802@slaphack.com>
References: <200506231924.j5NJOvLA031008@laptop11.inf.utfsm.cl>
	 <42BB31E9.50805@slaphack.com>
	 <1119570225.18655.75.camel@localhost.localdomain>
	 <42BB7B32.4010100@slaphack.com>
	 <1119612849.17063.105.camel@localhost.localdomain>
	 <42BCCC32.1090802@slaphack.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119806605.28649.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 26 Jun 2005 18:23:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-06-25 at 04:14, David Masover wrote:
> Right, but even if I was a door geek, changing hinges costs more than
> changing code.  Now, if I were building a new house and I happened to

Probably not, programmers are expensive 8)

> DVDs are cheap nowdays:
> http://www.newegg.com/Product/Product.asp?Item=N82E16817502002

> Ok, you might need two of those.  Still, it's not much, unless that's

At least four because the media decay patterns are not well understood.
So you need raid DVD too 8)

> > 1. It must work
> > 2. It must be clean code that follows the kernel style
> > 3. It must not break other stuff
> > 4. It needs a maintainer who won't get bored 12 months later and only
> > support reiser5

> It's #2 and #3 that I'm worried about.  #4 is a little unfair, and I can
> verify that #1 is satisfied.

Please review the 2.5 history of reiserfs3 if you believe so

