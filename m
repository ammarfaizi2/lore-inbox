Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136308AbRECJes>; Thu, 3 May 2001 05:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136309AbRECJej>; Thu, 3 May 2001 05:34:39 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:49157 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136298AbRECJeb>; Thu, 3 May 2001 05:34:31 -0400
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
To: kaih@khms.westfalen.de (Kai Henningsen)
Date: Thu, 3 May 2001 10:37:12 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <80BTbB7Hw-B@khms.westfalen.de> from "Kai Henningsen" at May 03, 2001 09:13:00 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14vFXu-0005FC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > PS: Hmm, how do you do timewarp for just one userland appliation with
> > this installed?
> 
> 1. What on earth for?

Y2K testing was one previous example.

> 2. How do you do it today, and why wouldn't that work?

LD_PRELOAD and providing its still using a lib call it would. I dont see the
original posters problem


