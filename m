Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262859AbVDHPwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262859AbVDHPwe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 11:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262860AbVDHPwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 11:52:34 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:3767 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262859AbVDHPw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 11:52:28 -0400
Message-Id: <200504081552.j38FqBCH012050@laptop11.inf.utfsm.cl>
To: domen@coderock.org
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, didickman@yahoo.com
Subject: Re: [patch 2/8] correctly name the Shell sort 
In-Reply-To: Message from domen@coderock.org 
   of "Fri, 08 Apr 2005 09:50:53 +0200." <20050408075054.25DF41F3A3@trashy.coderock.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Fri, 08 Apr 2005 11:52:10 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Fri, 08 Apr 2005 11:52:05 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

domen@coderock.org said:

> As per http://www.nist.gov/dads/HTML/shellsort.html, this should be
> referred to as a Shell sort. Shell-Metzner is a misnomer.

> Signed-off-by: Daniel Dickman <didickman@yahoo.com>
> Signed-off-by: Domen Puncer <domen@coderock.org>

Why not use the sort routine from lib/sort.c?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
