Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269888AbRHEBAn>; Sat, 4 Aug 2001 21:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269889AbRHEBAd>; Sat, 4 Aug 2001 21:00:33 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:18697 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269890AbRHEBAb>; Sat, 4 Aug 2001 21:00:31 -0400
Subject: Re: MTRR and Athlon Processors
To: pgallen@randomlogic.com (Paul G. Allen)
Date: Sun, 5 Aug 2001 02:01:55 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux kernel developer's mailing list)
In-Reply-To: <no.id> from "Paul G. Allen" at Aug 04, 2001 05:47:49 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15TCIm-0005i6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is the mtrr code supposed to work properly for Athlon (Model 4) in
> kernel 2.4.7?
> 
> I still get mtrr errors/warnings.

Mismatched mtrr warnings indicate bios writers who cannot read
specifications. The kernel will fix up after it
