Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261351AbREPXiC>; Wed, 16 May 2001 19:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262141AbREPXhw>; Wed, 16 May 2001 19:37:52 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:32013 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261351AbREPXhf>; Wed, 16 May 2001 19:37:35 -0400
Subject: Re: [PATCH] rootfs (part 1)
To: viro@math.psu.edu (Alexander Viro)
Date: Thu, 17 May 2001 00:33:32 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0105160756210.24199-100000@weyl.math.psu.edu> from "Alexander Viro" at May 16, 2001 08:12:52 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150AnM-0004cy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	Linus, patch is the first chunk of rootfs stuff. I've tried to
> get it as small as possible - all it does is addition of absolute root
> on ramfs and necessary changes to mount_root/change_root/sys_pivot_root
> and follow_dotdot. Real root is mounted atop of the "absolute" one.

Surely this is getting right into 2.5 stuff. 

