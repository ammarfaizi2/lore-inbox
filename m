Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270214AbRHGOSg>; Tue, 7 Aug 2001 10:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270215AbRHGOS1>; Tue, 7 Aug 2001 10:18:27 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:30477 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270214AbRHGOSP>; Tue, 7 Aug 2001 10:18:15 -0400
Subject: Re: Encrypted Swap
To: helgehaf@idb.hist.no (Helge Hafting)
Date: Tue, 7 Aug 2001 15:17:56 +0100 (BST)
Cc: crutcher@datastacks.com (Crutcher Dunnavant), linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Helge Hafting" at Aug 07, 2001 11:23:04 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15U7gC-0002xe-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A relatively cheap way might be a custom pci
> card with a self-destruct RAM bank for
> storing the decryption keys.  Opening the 
> safe cause the card to zero the RAM.  

IBM sell crypto PCI cards with anti tamper environments, they have
development drivers on their oss site too
