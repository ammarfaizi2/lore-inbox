Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276579AbRI2S3T>; Sat, 29 Sep 2001 14:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276578AbRI2S3J>; Sat, 29 Sep 2001 14:29:09 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8977 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276577AbRI2S2u>; Sat, 29 Sep 2001 14:28:50 -0400
Subject: Re: (lkml)Re: floppy hang with 2.4.9-ac1x
To: thunder7@xs4all.nl
Date: Sat, 29 Sep 2001 19:34:09 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010929180359.A871@middle.of.nowhere> from "thunder7@xs4all.nl" at Sep 29, 2001 06:03:59 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15nOwD-0002e4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Knowing exactly which release would be useful
> 
> It worked with 2.4.9-ac15 and before, and it doesn't work with
> 2.4.9-ac16.

Ok that sounds like another instance of the Ingo ksoftirq changes breaking
stuff - thanks
