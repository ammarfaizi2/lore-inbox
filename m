Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276204AbRJUPCx>; Sun, 21 Oct 2001 11:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276215AbRJUPCn>; Sun, 21 Oct 2001 11:02:43 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36368 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276204AbRJUPCb>; Sun, 21 Oct 2001 11:02:31 -0400
Subject: Re: [compile bug] 2.4.13-pre4 | i2o_pci.c:165 structure has no member named `pdev'
To: brownfld@irridia.com (Ken Brownfield)
Date: Sun, 21 Oct 2001 16:09:20 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, david@blue-labs.org (David Ford)
In-Reply-To: <20011019185603.A13465@asooo.flowerfire.com> from "Ken Brownfield" at Oct 19, 2001 06:56:03 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15vKE4-0006dB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It looks like this has been an issue since -pre1 -- we've seen this too
> with i2o as a module.  Between .11 and the parport issue with .12, it's
> certainly been interesting recently. :)
> Anyone have any news on this?  Sorry if I've missed it.

Its broken until I finish merging the i2o changes with Linus. Its ok in the
-ac tree and indeed you can use the -ac changes to get to where I should be
merge dwith Linus
