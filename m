Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbVFAPm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbVFAPm6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 11:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbVFAPls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 11:41:48 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:21907 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261390AbVFAPlV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 11:41:21 -0400
Message-Id: <200506010223.j512NgeC005179@laptop11.inf.utfsm.cl>
To: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
cc: Gerd Knorr <kraxel@suse.de>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>, mrmacman_g4@mac.com,
       toon@hout.vanvergehaald.nl, ltd@cisco.com, linux-kernel@vger.kernel.org,
       dtor_core@ameritech.net, 7eggert@gmx.de
Subject: Re: OT] Joerg Schilling flames Linux on his Blog 
In-Reply-To: Message from lsorense@csclub.uwaterloo.ca (Lennart Sorensen) 
   of "Tue, 31 May 2005 15:05:56 -0400." <20050531190556.GK23621@csclub.uwaterloo.ca> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Tue, 31 May 2005 22:23:42 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Wed, 01 Jun 2005 11:35:52 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen <lsorense@csclub.uwaterloo.ca> wrote:

[...]

> Well I remember the first time I saw devfs running, I thought "Wow
> finally I have a way to find the disc that is scsi id 3 on controller 0
> even if I add a device at id 2 after setting up the system", something
> most unix systems have always had, but linux made hard (you had to
> somehow figure out which id mapped to which /dev/sd* entry, which from a
> users perspective wasn't trivial, and of course keeping your fstab in
> sync with the mapping was a pain).

Why? Just use LABELs, ou UUIDs.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
