Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293204AbSCOTt2>; Fri, 15 Mar 2002 14:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293230AbSCOTtS>; Fri, 15 Mar 2002 14:49:18 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:41487 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293204AbSCOTtD>; Fri, 15 Mar 2002 14:49:03 -0500
Subject: Re: Kernel Level DHCP Versus udhcp
To: abdij.bhat@kshema.com
Date: Fri, 15 Mar 2002 20:04:29 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <001c01c1cc56$b38a3ec0$8134aa88@cam.pace.co.uk> from "Abdij Bhat" at Mar 15, 2002 07:22:08 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lxwD-0004W9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Can some body help me with this. I believe it is used only for the remote
> booting, with the documentation currently available to me. How correct am I?
> Can I replace the udhcp client with this one? How much of a change will I
> need to do for the replacement?

its just used in kernel for booting a diskless box. Nothing else
