Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262106AbRENOsm>; Mon, 14 May 2001 10:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262112AbRENOsc>; Mon, 14 May 2001 10:48:32 -0400
Received: from 13dyn155.delft.casema.net ([212.64.76.155]:59918 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S262106AbRENOsW>; Mon, 14 May 2001 10:48:22 -0400
Message-Id: <200105141448.QAA17400@cave.bitwizard.nl>
Subject: [PATCH] RIO, SX, driver update.
To: Linus Torvalds <Torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Date: Mon, 14 May 2001 16:48:12 +0200 (MEST)
CC: patrick@BitWizard.nl
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus, Alan, 

The patch below implements breaks (correctly) for the RIO and SX
cards.

We started out trying to fix one thing, but found that the 2.4.4 rio
driver was behind on several patches.

	Roger Wolff. 
	Patrick van de Lageweg. 

-----------


-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
