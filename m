Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129969AbRADQcz>; Thu, 4 Jan 2001 11:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130027AbRADQcp>; Thu, 4 Jan 2001 11:32:45 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:65038 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129969AbRADQce>; Thu, 4 Jan 2001 11:32:34 -0500
Subject: Re: Compilation error in Red Hat 6.2
To: mpradhan@healthnet.org.np
Date: Thu, 4 Jan 2001 16:33:53 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A54F8BD.14576.3D66AD@localhost> from "mpradhan@healthnet.org.np" at Jan 04, 2001 10:27:09 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14EDKs-0005yl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am getting one error while compiling kernal in Red Hat 6.2:  
> VFS: cannot open root device 08:01 > Kernel panic: VFS: 
> unable to mount root fs on 08:01 >
>  I have used make bzImage to make the 
> new image after make dep; > make clean.

You've not compiled in the drivers for your hard disk
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
