Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbVGSVyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbVGSVyh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 17:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVGSVye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 17:54:34 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:34435 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261724AbVGSVxc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 17:53:32 -0400
Message-Id: <200507192153.j6JLrKUU012015@laptop11.inf.utfsm.cl>
To: Etienne Lorrain <etienne_lorrain@yahoo.fr>
cc: linux-kernel@vger.kernel.org, machida@sm.sony.co.jp
Subject: Re: [RFD] FAT robustness 
In-Reply-To: Message from Etienne Lorrain <etienne_lorrain@yahoo.fr> 
   of "Tue, 19 Jul 2005 18:58:21 +0200." <20050719165821.96544.qmail@web26907.mail.ukl.yahoo.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Tue, 19 Jul 2005 17:53:20 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Tue, 19 Jul 2005 17:53:22 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Etienne Lorrain <etienne_lorrain@yahoo.fr> wrote:
> > I'd like to have a discussion about FAT robustness.
> > Please give your thought, comments and related issues.

>   What I would like is to treat completely differently writing to
>  FAT (writing to a removeable drive) which need a complete "mount",
>  and just reading quickly a file (a standard use of removeable devices).

Sounds like a job for mtools(1).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
