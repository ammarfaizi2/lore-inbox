Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136084AbRDVMuF>; Sun, 22 Apr 2001 08:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136083AbRDVMtz>; Sun, 22 Apr 2001 08:49:55 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:43279 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136084AbRDVMtl>; Sun, 22 Apr 2001 08:49:41 -0400
Subject: Re: Linux 2.4.3-ac12
To: rmk@arm.linux.org.uk (Russell King)
Date: Sun, 22 Apr 2001 13:51:19 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), manuel@mclure.org (Manuel McLure),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010422131803.C20807@flint.arm.linux.org.uk> from "Russell King" at Apr 22, 2001 01:18:03 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14rJKj-0005mR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, Apr 22, 2001 at 01:11:31PM +0100, Alan Cox wrote:
> > This is from Linus tree. You currently need gcc 2.96 or higher to build
> > the 2.4.x kernel. 
> 
> Which goes back to the old argument that 2.96 is a redhat-ism and not a
> real compiler.

I didnt say it was a good idea.. People want to build with egcs and especially
with 2.95.3

> Anyway, the work around is a trivial one that I've already posted to the
> list, including the necessary GCC version tests.  Additionally David
> Howells has posted a patch to remove the __builtin_expect stuff, so
> this is a non-issue now.

I've applied one of them to my tree already too.
