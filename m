Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310940AbSCPWNy>; Sat, 16 Mar 2002 17:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311166AbSCPWNo>; Sat, 16 Mar 2002 17:13:44 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62219 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311040AbSCPWNf>; Sat, 16 Mar 2002 17:13:35 -0500
Subject: Re: [PATCH] devexit fixes in i82092.c
To: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 16 Mar 2002 22:28:13 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        torvalds@transmeta.com (Linus Torvalds),
        andersg@0x63.nu (Anders Gustafsson), arjanv@redhat.com,
        linux-kernel@vger.kernel.org, mochel@osdl.org
In-Reply-To: <m1hengxj9t.fsf@frodo.biederman.org> from "Eric W. Biederman" at Mar 16, 2002 03:03:26 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16mMer-0007Q4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In the general reboot case yes it is a BIOS bug.  In the general Linux
> booting Linux case there is no BIOS involved.

In that case yes I can see why you want to turn the bus masters off when you
boot the new kernel
