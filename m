Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262565AbRENXDG>; Mon, 14 May 2001 19:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262554AbRENXC4>; Mon, 14 May 2001 19:02:56 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:25867 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262565AbRENXCw>; Mon, 14 May 2001 19:02:52 -0400
Subject: Re: LANANA: To Pending Device Number Registrants
To: viro@math.psu.edu (Alexander Viro)
Date: Mon, 14 May 2001 23:58:39 +0100 (BST)
Cc: hpa@transmeta.com (H. Peter Anvin), alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.GSO.4.21.0105141856090.19333-100000@weyl.math.psu.edu> from "Alexander Viro" at May 14, 2001 07:00:21 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14zRIW-0001dr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Oh, _that_ one. <shrug> pass rootname=driver!name (or whatever syntax
> you prefer) to the kernel and call do_mount() instead of sys_mknod() in
> prepare_namespace() (rootfs patch). BFD.

Yet another 2.5 project. If Linus wants to go play with name driven devices
and you want to help him great, but if he'd care to put out
linux-2.5.0.tar.gz _before_ starting that would be good for all of us


