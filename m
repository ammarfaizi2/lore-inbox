Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314451AbSEBOHw>; Thu, 2 May 2002 10:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314454AbSEBOHv>; Thu, 2 May 2002 10:07:51 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13579 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314451AbSEBOHu>; Thu, 2 May 2002 10:07:50 -0400
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Thu, 2 May 2002 15:26:08 +0100 (BST)
Cc: kaos@ocs.com.au (Keith Owens), linux-kernel@vger.kernel.org
In-Reply-To: <3CD135D4.5060506@evision-ventures.com> from "Martin Dalecki" at May 02, 2002 02:49:24 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E173HX6-00041D-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > change configs, rebuild without make mrproper).  To do modversions
> > right needs a new version of modutils as well, there is no chance of
> > that work being started until kbuild 2.5 is in the kernel.
> 
> How many years was it that I was telling that symbol versioning is
> a silly concept not solving any single problem and the implementation is to say
> the least ugly?

Modversions solves a huge number of problems very very well. The fact that
you don't like it doesn't change the reality of the situation.
