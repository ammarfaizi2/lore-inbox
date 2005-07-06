Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262256AbVGFQ4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbVGFQ4T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 12:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262334AbVGFQux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 12:50:53 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:48039 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262256AbVGFMbD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 08:31:03 -0400
Message-Id: <200507060255.j662tndQ005308@laptop11.inf.utfsm.cl>
To: David Masover <ninja@slaphack.com>
cc: Hans Reiser <reiser@namesys.com>, Hubert Chan <hubert@uhoreg.ca>,
       Ross Biro <ross.biro@gmail.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Kyle Moffett <mrmacman_g4@mac.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins 
In-Reply-To: Message from David Masover <ninja@slaphack.com> 
   of "Tue, 05 Jul 2005 18:00:56 EST." <42CB1128.6000000@slaphack.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Tue, 05 Jul 2005 22:55:49 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Wed, 06 Jul 2005 08:30:02 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover <ninja@slaphack.com> wrote:

[...]

> Just don't allow user-created hardlinks inside either metafs (/meta) or
> the magical meta directory inside files.

And what is it useful for, after its advantage was that it was /exactly/
like regular files &c, and now it is severely crippled?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
