Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317138AbSEXOiZ>; Fri, 24 May 2002 10:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317144AbSEXOiX>; Fri, 24 May 2002 10:38:23 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:64267 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317138AbSEXOiQ>; Fri, 24 May 2002 10:38:16 -0400
Subject: Re: Linux crypto?
To: tori@ringstrom.mine.nu (Tobias Ringstrom)
Date: Fri, 24 May 2002 15:58:39 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), imipak@yahoo.com (Myrddin Ambrosius),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0205232343260.18503-100000@boris.prodako.se> from "Tobias Ringstrom" at May 23, 2002 11:46:01 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17BGWd-0006S2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 22 May 2002, Alan Cox wrote:
> 
> > What of it do you actually need in kernel space - encrypted file systems
> > certainly ought to be there but are not very well handled in Linux proper
> > right now - but anything else ?
> 
> IPsec.

At the moment there doesn't appear to be an IPsec stack we can merge however
