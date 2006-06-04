Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932340AbWFDXvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWFDXvs (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 19:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWFDXvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 19:51:47 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:19417 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932334AbWFDXvq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 19:51:46 -0400
Message-Id: <200606042249.k54MnbFW010695@laptop11.inf.utfsm.cl>
To: Joachim Fritschi <jfritschi@freenet.de>
cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, ak@suse.de
Subject: Re: [PATCH 3/4] Twofish cipher - i586 assembler 
In-Reply-To: Message from Joachim Fritschi <jfritschi@freenet.de> 
   of "Sun, 04 Jun 2006 15:16:38 +0200." <200606041516.38998.jfritschi@freenet.de> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Sun, 04 Jun 2006 18:49:37 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Delayed for 01:00:06 by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Sun, 04 Jun 2006 19:49:55 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joachim Fritschi <jfritschi@freenet.de> wrote:
> This patch adds the twofish i586 assembler routine. 

What performance impact does this have on a variety of machines? Is twofish
used enough for this to be relevant?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
