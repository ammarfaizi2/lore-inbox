Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129192AbRBRTy0>; Sun, 18 Feb 2001 14:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129247AbRBRTyP>; Sun, 18 Feb 2001 14:54:15 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:64263 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129192AbRBRTyA>;
	Sun, 18 Feb 2001 14:54:00 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200102181953.WAA27509@ms2.inr.ac.ru>
Subject: Re: MTU and 2.4.x kernel
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Sun, 18 Feb 2001 22:53:29 +0300 (MSK)
Cc: alan@lxorguk.ukuu.org.uk, roger@kea.GRace.CRi.NZ,
        linux-kernel@vger.kernel.org
In-Reply-To: <E14TVWn-0000vQ-00@the-village.bc.nu> from "Alan Cox" at Feb 15, 1 09:01:21 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Message size != MTU.

Alan, you misunderstand _sense_ of the problem.

Fragmentation does _not_ work on poor internet more. At all.
Look at original report. It failed _only_ because his intemediate
node failed to forward fragmented packets.

Alexey
