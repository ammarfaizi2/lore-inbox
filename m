Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129069AbRBPI7K>; Fri, 16 Feb 2001 03:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129098AbRBPI7B>; Fri, 16 Feb 2001 03:59:01 -0500
Received: from 13dyn103.delft.casema.net ([212.64.76.103]:50448 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S129069AbRBPI65>; Fri, 16 Feb 2001 03:58:57 -0500
Message-Id: <200102160858.JAA02472@cave.bitwizard.nl>
Subject: 8139 full duplex?
To: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Date: Fri, 16 Feb 2001 09:58:53 +0100 (MET)
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

I have a bunch of computers with 8139 cards. When I moved the cables
over from my hub to my new switch all the "full duplex" lights came on
immediately.

Would this mean that the driver/card already were in full-duplex? That
would explain me seeing way too many collisions on that old hub (which
obviously doesn't support full-duplex).

(Some machines run 2.2 kernels, others run 2.4 kernels some run the
old driver, others run the 8139too driver). 

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
