Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135611AbREBPxq>; Wed, 2 May 2001 11:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135601AbREBPx3>; Wed, 2 May 2001 11:53:29 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:32528 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135599AbREBPwE>; Wed, 2 May 2001 11:52:04 -0400
Subject: Re: TV viewing broken in 2.4.4 (and 2.4.3)
To: robert.holmberg@helsinki.fi (Robert Holmberg)
Date: Wed, 2 May 2001 16:55:54 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200105021517.f42FHtn29038@no-spam.it.helsinki.fi> from "Robert Holmberg" at May 02, 2001 06:17:55 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uyyr-0003pE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I reported this bug before for 2.4.3 and a patch which fixed (or worked around) this problem was posted. The patch still works for 2.4.4

The fixup is bogus. Im not sure who wrote it or why. Its not the right fix for
the VIA later chip bugs. Its not the right way to do a two chip combination
fixup if that was really needed.

Deleting it seems sensible


Alan

