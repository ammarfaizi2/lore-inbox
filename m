Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266295AbUFPO2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266295AbUFPO2A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 10:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266321AbUFPO0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 10:26:24 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:5805 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S266307AbUFPOYV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 10:24:21 -0400
Message-Id: <200406160149.i5G1nCC1004688@eeyore.valparaiso.cl>
To: Alexandre Oliva <aoliva@redhat.com>
cc: Matthias Schniedermeyer <ms@citd.de>,
       Cesar Eduardo Barros <cesarb@nitnet.com.br>,
       linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>
Subject: Re: [PATCH] O_NOATIME support 
In-Reply-To: Message from Alexandre Oliva <aoliva@redhat.com> 
   of "15 Jun 2004 16:02:12 -0300." <orbrjkabm3.fsf@free.redhat.lsd.ic.unicamp.br> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Tue, 15 Jun 2004 21:49:12 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Oliva <aoliva@redhat.com> said:
> On Jun 14, 2004, Matthias Schniedermeyer <ms@citd.de> wrote:

[...]

> -> You can disable updating the atime for the whole filesystem.
> 
> As a sysadmin that intends to use atime as proof, you don't do that.

And you disable touch(1) too?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
