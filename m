Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266802AbUIVTwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266802AbUIVTwP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 15:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266786AbUIVTwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 15:52:15 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:36015 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S266838AbUIVTtM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 15:49:12 -0400
Message-Id: <200409221947.i8MJlnSX003715@laptop11.inf.utfsm.cl>
To: Timothy Miller <miller@techsource.com>
cc: Jeff Garzik <jgarzik@pobox.com>, David Woodhouse <dwmw2@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jeremy Higdon <jeremy@sgi.com>
Subject: Re: [DOC] Linux kernel patch submission format 
In-Reply-To: Message from Timothy Miller <miller@techsource.com> 
   of "Wed, 22 Sep 2004 14:59:46 -0400." <4151CBA2.1020005@techsource.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Wed, 22 Sep 2004 15:47:49 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller <miller@techsource.com> said:
> Does the Linux kernel source tree include a shell script which will 
> compare two trees, create patches, and ask the necessary questions so as 
> to format the files correctly with all the right stuff?

diff(1) does what you want...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
