Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131802AbQJ2QS2>; Sun, 29 Oct 2000 11:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131872AbQJ2QST>; Sun, 29 Oct 2000 11:18:19 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:49449 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131802AbQJ2QSB>; Sun, 29 Oct 2000 11:18:01 -0500
Subject: Re: gcc question (off topic)
To: jkelley@iei.net (Jerry Kelley)
Date: Sun, 29 Oct 2000 16:18:55 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (linux kernel)
In-Reply-To: <001801c041bb$5e894c80$0a00a8c0@gamma> from "Jerry Kelley" at Oct 29, 2000 10:17:36 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13pvAf-0006AN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can gcc generate ASM output with the source lines from the C file
> interspersed as comments?

Not afak directly. The makelst stuff in 2.2.18pre IBM contributed claims to
do the job though

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
