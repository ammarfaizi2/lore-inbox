Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264955AbUD2UDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264955AbUD2UDN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 16:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264958AbUD2UDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 16:03:13 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:7842 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S264955AbUD2UCm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 16:02:42 -0400
Message-Id: <200404292001.i3TK1BYe005147@eeyore.valparaiso.cl>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       brettspamacct@fastclick.com, linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell 
In-Reply-To: Your message of "Thu, 29 Apr 2004 10:21:24 +1000."
             <40904A84.2030307@yahoo.com.au> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Thu, 29 Apr 2004 16:01:11 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> said:

[...]

> I don't know. What if you have some huge application that only
> runs once per day for 10 minutes? Do you want it to be consuming
> 100MB of your memory for the other 23 hours and 50 minutes for
> no good reason?

How on earth is the kernel supposed to know that for this one particular
job you don't care if it takes 3 hours instead of 10 minutes, just because
you don't want to spare enough preciousss RAM?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
