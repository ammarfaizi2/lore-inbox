Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbVLUQCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbVLUQCh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 11:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbVLUQCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 11:02:37 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:59611 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932461AbVLUQCh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 11:02:37 -0500
Message-Id: <200512211602.jBLG2QKM003368@laptop11.inf.utfsm.cl>
To: kloska@scienion.de
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: vfat question 
In-Reply-To: Message from Sebastian Kloska <kloska@scienion.de> 
   of "Wed, 21 Dec 2005 10:24:54 BST." <43A91F66.4050607@scienion.de> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
Date: Wed, 21 Dec 2005 13:02:26 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Wed, 21 Dec 2005 13:02:26 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Kloska <kloska@scienion.de> wrote:
> Is there an "official" way of  to move FAT entries
> around in the vfat code of the kernel ? I'd like
> to change ordering of vfat entries.

Why don't you do that off-line, in a userland program? Should be easier
(and safer).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
