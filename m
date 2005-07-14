Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262645AbVGNU3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262645AbVGNU3Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 16:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbVGNUGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 16:06:34 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:45222 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S263109AbVGNUF3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 16:05:29 -0400
Message-Id: <200507142005.j6EK5Hhn030304@laptop11.inf.utfsm.cl>
To: Nicholas Hans Simmonds <nhstux@gmail.com>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Nathan Scott <nathans@sgi.com>,
       linux-kernel@vger.kernel.org, "Andrew G. Morgan" <morgan@transmeta.com>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] Filesystem capabilities support 
In-Reply-To: Message from Nicholas Hans Simmonds <nhstux@gmail.com> 
   of "Thu, 14 Jul 2005 05:29:34 +0100." <20050714042934.GA25447@laptop> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Thu, 14 Jul 2005 16:05:17 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Thu, 14 Jul 2005 16:05:18 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Hans Simmonds <nhstux@gmail.com> wrote:

[...]

> Other than this, what are the general thoughts about this method as
> opposed to just using a well defined byte order?

I'd prefer a defined byte order. That way it won't bite too hard if I
happen to move a filesystem (image) from PC to SPARC or whatever.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
