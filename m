Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312644AbSDFRsF>; Sat, 6 Apr 2002 12:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312681AbSDFRsE>; Sat, 6 Apr 2002 12:48:04 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22800 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312644AbSDFRsD>; Sat, 6 Apr 2002 12:48:03 -0500
Subject: Re: Kernel panic
To: djmunds@gmx.net (Daniel Mundy)
Date: Sat, 6 Apr 2002 19:05:22 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <20020406041640.GA451@gmx.net> from "Daniel Mundy" at Apr 06, 2002 01:46:40 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16tuZ0-0002OC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> These are the messages I see on my terminal, I cannot see any more as this is the highest mode my monitor can support:
> 
> -------------------------
> <1>Unable to handle kernel NULL pointer deference at virtual address 00000000
> Oops: 0000
> CPU:   0
> EIP:   0010:[<00000000>]   Tainted: P

What binary only modules  do you have loaded given the tainted marker
is set ?
