Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129026AbRBFLX0>; Tue, 6 Feb 2001 06:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129027AbRBFLXQ>; Tue, 6 Feb 2001 06:23:16 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:11787 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129026AbRBFLXI>; Tue, 6 Feb 2001 06:23:08 -0500
Subject: Re: 2.4.x: spinlock problem
To: Ulrich.Windl@rz.uni-regensburg.de (Ulrich Windl)
Date: Tue, 6 Feb 2001 11:23:34 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A7FDE02.17474.A94DE@localhost> from "Ulrich Windl" at Feb 06, 2001 11:20:48 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Q6Dh-0005Ot-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> With 2.4.1 the kernel is incredibly slow, so you can watch the 
> individual lines of kernel boot be printed on the screen.

Turn off ACPI
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
