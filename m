Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135986AbREIKUv>; Wed, 9 May 2001 06:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136045AbREIKUb>; Wed, 9 May 2001 06:20:31 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:61448 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135986AbREIKUa>; Wed, 9 May 2001 06:20:30 -0400
Subject: Re: Question: Status of VIA chipsets and 2.2 kernels
To: robert@coorong.anu.edu.au (Robert Cohen)
Date: Wed, 9 May 2001 11:23:57 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3AF8EE3A.21932E5D@tltsu.anu.edu.au> from "Robert Cohen" at May 09, 2001 05:14:02 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14xR8S-0001zQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Problems Ive been hearing about include DMA disk transfers between
> channels. Some reports say these only occur with Western digital disks.

Not the case

> The 2 athlon boards listed include an onboard promise IDE controller. So
> I should be OK if I use this for disks, right?

Maybe. Consult your vendor and BIOS supplier. Given the current noticable
absence of exact info in the public domain I'd be careful they will guarantee
the VIA chipset problem fixes are in the BIOS. If they give you a blank look
go elsewhere


