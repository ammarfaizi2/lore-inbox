Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262287AbVAJPQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262287AbVAJPQv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 10:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbVAJPQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 10:16:50 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:57810 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262287AbVAJPQt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 10:16:49 -0500
Message-Id: <200501101515.j0AFF40k029882@laptop11.inf.utfsm.cl>
To: Arjan van de Ven <arjan@infradead.org>
cc: utz lehmann <lkml@s2y4n2c.de>, LKML <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH] scheduling priorities with rlimit 
In-Reply-To: Message from Arjan van de Ven <arjan@infradead.org> 
   of "Sun, 09 Jan 2005 20:06:37 BST." <1105297598.4173.52.camel@laptopd505.fenrus.org> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Mon, 10 Jan 2005 12:15:04 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.4 (inti.inf.utfsm.cl [200.1.19.1]); Mon, 10 Jan 2005 12:15:09 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> said:

[...]

> Also I like the idea of allowing sysadmins to make certain users/groups
> nice levels 5 and higher (think a university machine that makes all
> students nice 5 and higher only, while giving staff 0 and higher, and
> the sysadmin -5 and higher ;)

AFAIU, this can be done via PAM. No kernel involvment required.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
