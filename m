Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276344AbRJUQx6>; Sun, 21 Oct 2001 12:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276347AbRJUQxs>; Sun, 21 Oct 2001 12:53:48 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:29201 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276344AbRJUQxc>; Sun, 21 Oct 2001 12:53:32 -0400
Subject: Re: What is /boot/modules-info
To: tdiehl@rogueind.com (Tom Diehl)
Date: Sun, 21 Oct 2001 18:00:16 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <Pine.LNX.4.33.0110160815030.581-100000@tigger.rogueind.com> from "Tom Diehl" at Oct 16, 2001 08:17:23 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15vLxQ-0007FD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Its a table of drivers, arguments to the module etc for common modules,
> > used by the various config tools to help guide installs etc
> 
> Is there any way to regenerate it for non redhat kernels?

I dont know how it was originally generated or if its hand collected.

I suspect modinfo is the tool you need
