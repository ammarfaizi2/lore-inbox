Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267534AbRHKNG0>; Sat, 11 Aug 2001 09:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267542AbRHKNGQ>; Sat, 11 Aug 2001 09:06:16 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:17927 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267534AbRHKNGK>; Sat, 11 Aug 2001 09:06:10 -0400
Subject: Re: complete_and_exit
To: moz@compsoc.man.ac.uk (John Levon)
Date: Sat, 11 Aug 2001 14:04:57 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010811030442.A5238@compsoc.man.ac.uk> from "John Levon" at Aug 11, 2001 03:04:43 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15VYRl-0002aB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is complete_and_exit() going to be in 2.4.8 ? Trying to support before and
> after the change is really more of a pain than it could be right now, as
> you can't use LINUX_VERSION_CODE to detect ac kernels.

I've no idea. It depends whether Linus takes it when its fed to him or not.
