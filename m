Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129965AbQLBNjf>; Sat, 2 Dec 2000 08:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130322AbQLBNjY>; Sat, 2 Dec 2000 08:39:24 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1150 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129965AbQLBNjM>; Sat, 2 Dec 2000 08:39:12 -0500
Subject: Re: [patch-2.4.0-test12-pre3] microcode update for P4 (fwd)
To: hpa@zytor.com (H. Peter Anvin)
Date: Sat, 2 Dec 2000 13:08:46 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <90a1ca$3rt$1@cesium.transmeta.com> from "H. Peter Anvin" at Dec 01, 2000 09:29:46 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E142CPJ-0001Ww-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please call these MSR_* instead, "IA32_*" isn't very descriptive,
> besides, the preferred prefix in existing locations in the Linux
> kernel is "X86_", e.g. X86_EFLAGS_IF or X86_CR4_PSE.  I think there

I think I agree with Tigran's naming. These are IA32 registers not X86 ones ;)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
