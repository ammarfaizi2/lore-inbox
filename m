Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261664AbREOWdS>; Tue, 15 May 2001 18:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261665AbREOWdI>; Tue, 15 May 2001 18:33:08 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:41989 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261664AbREOWdC>; Tue, 15 May 2001 18:33:02 -0400
Subject: Re: LANANA: To Pending Device Number Registrants
To: hpa@transmeta.com (H. Peter Anvin)
Date: Tue, 15 May 2001 23:28:56 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), chip@valinux.com (Chip Salzenberg),
        torvalds@transmeta.com (Linus Torvalds),
        neilb@cse.unsw.edu.au (Neil Brown),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        viro@math.psu.edu
In-Reply-To: <3B01AB60.76CFE75A@transmeta.com> from "H. Peter Anvin" at May 15, 2001 03:19:12 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14znJI-0003EY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1. is of course a problem in itself.  Someone who creates overlapping
> ioctls should be spanked, hard.

No argument there. But there is no LANANA ioctl body

> Agreed, but "determining type of device" and "determining if interface X
> is available on this device" are different operations.  If the latter is
> what you want, you want to *explicitly* perform the latter operation.

Both should be clean and explicit
