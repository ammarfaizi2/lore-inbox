Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271537AbRHZUVV>; Sun, 26 Aug 2001 16:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271522AbRHZUVM>; Sun, 26 Aug 2001 16:21:12 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57872 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271515AbRHZUU6>; Sun, 26 Aug 2001 16:20:58 -0400
Subject: Re: VCool - cool your Athlon/Duron during idle
To: 520028810828-0001@t-online.de
Date: Sun, 26 Aug 2001 21:24:07 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <87pu9i7frm.fsf@psyche.kn-bremen.de> from "Joerg Plate" at Aug 26, 2001 10:00:45 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15b6Rz-0002hM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Try <http://mpet.freeservers.com/LVCool.html>
> and <http://mpet.freeservers.com/VC_Theory.html>

That says it all for me

"For example I noticed that with the bus disconnect enabled a captured video
is full of dropped or garbled lines."

Streaming video is not really different to most bus mastering IDE. Its
just pci card initiated memory writes with timing constraints. For some
reason having my disk do that makes me very nervous

