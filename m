Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265921AbUFOULx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265921AbUFOULx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 16:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265922AbUFOULx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 16:11:53 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:23451 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S265921AbUFOULr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 16:11:47 -0400
Message-Id: <200406152011.i5FKBBif021275@eeyore.valparaiso.cl>
To: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: concurrent acces by make menuconfig 
In-Reply-To: Message from =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com> 
   of "Tue, 15 Jun 2004 14:18:30 GMT." <20040615141830.A6241@beton.cybernet.src> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Tue, 15 Jun 2004 16:11:11 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com> said:
> Is it correct to run make menuconfig (without achanging anything,
> just to study the current configuration) while a make bzImage is running
> on another console when the version is 2.4.25?

Should make no difference at all unless you save a changed configuration.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
