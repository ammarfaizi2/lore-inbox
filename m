Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264161AbUDVPqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264161AbUDVPqm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 11:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264155AbUDVPqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 11:46:42 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:13761 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S264161AbUDVPql (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 11:46:41 -0400
Message-Id: <200404221546.i3MFka6w004059@eeyore.valparaiso.cl>
To: Kim Holviala <kim@holviala.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] psmouse: fix mouse hotplugging 
In-Reply-To: Your message of "Thu, 22 Apr 2004 10:44:56 +0300."
             <200404221044.56294.kim@holviala.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Thu, 22 Apr 2004 11:46:35 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kim Holviala <kim@holviala.com> said:
> This patch fixes hotplugging of PS/2 devices on hardware which don't
> support hotplugging of PS/2 devices. In other words, most desktop
machines.

I have seen "hoplugging of mice" fry PS/2 ports, and heard of motherboards
killed that way. 
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
