Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317219AbSFLIxC>; Wed, 12 Jun 2002 04:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317232AbSFLIxB>; Wed, 12 Jun 2002 04:53:01 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11013 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317219AbSFLIxA>; Wed, 12 Jun 2002 04:53:00 -0400
Subject: Re: Serverworks OSB4 in impossible state
To: Martin.Wilck@Fujitsu-Siemens.com (Martin Wilck)
Date: Wed, 12 Jun 2002 10:14:50 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), osb4-bug@ide.cabal.tm,
        linux-kernel@vger.kernel.org (Linux Kernel mailing list)
In-Reply-To: <1023871648.23733.465.camel@biker.pdb.fsc.net> from "Martin Wilck" at Jun 12, 2002 10:47:28 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17I4DK-0007Lt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Would you concur that it would be reasonable to trigger only if
> 
> - the chipset version is < CSB5,
> - the drive is a hard disk,
> - and the drive did not report an error?
> 
> (I am not certain about the last condition, but from the descriptions 
> of the 4-byte-shift problem I have seen I infer that there was no drive
> error condition involved).

Entirely agreed

