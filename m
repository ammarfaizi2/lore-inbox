Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261834AbVF0F6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbVF0F6u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 01:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbVF0F6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 01:58:49 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:17578 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261834AbVF0FwQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 01:52:16 -0400
Message-Id: <200506270505.j5R55Zsx005315@laptop11.inf.utfsm.cl>
To: David Masover <ninja@slaphack.com>
cc: Hans Reiser <reiser@namesys.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins 
In-Reply-To: Message from David Masover <ninja@slaphack.com> 
   of "Sun, 26 Jun 2005 19:16:48 EST." <42BF4570.9010405@slaphack.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Mon, 27 Jun 2005 01:05:35 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover <ninja@slaphack.com> wrote:
> Hans Reiser wrote:

[...]

> > Reiser4 plugins are not per user, but per kernel.  They are compiled
> > in.  The model is intended to ease the development process, nothing
> > more.  Apologies if the naming suggests more.

What do you gain by this? It is just a kernel configuration option of
sorts? Just name mangling of existing mechanisms for no good reason at all?

> But, to avoid confusion, the inclusion of a crytocompress plugin in a
> given kernel doesn't mean that all files accessed from that kernel are
> encrypted and compressed.  It just means that you can pick an individual
> file and set it to be transparently encrypted/compressed.
> 
> That is what I meant by "enabled".  Not per-user, but per-file.

Wonderful! I carefully "transparently encrypt" my secret files, so
/everybody/ can read them! Now /that/ is progress!
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
