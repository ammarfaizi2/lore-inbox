Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132032AbRCYPSH>; Sun, 25 Mar 2001 10:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132034AbRCYPRr>; Sun, 25 Mar 2001 10:17:47 -0500
Received: from mail.t-intra.de ([62.156.146.210]:34417 "EHLO mail.t-intra.de")
	by vger.kernel.org with ESMTP id <S132032AbRCYPRg>;
	Sun, 25 Mar 2001 10:17:36 -0500
Message-Id: <200103251514.f2PFEmX14075@gate2.private.net>
From: "Otto Meier" <gf435@gmx.net>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Sun, 25 Mar 2001 17:16:19 +0200
Reply-To: "otto meier" <gf435@gmx.net>
X-Mailer: PMMail 2000 Professional (2.10.2010) For Windows 98 (4.10.2222)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: UDMA 5 on Promise ULTRA 100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I run linux 2.4.2-ac24 on the ULTRA 100 card with pdc 20267 Chip.

Drives are MAXTOR 53073H4 UDMA100.

Everything runs fine so far. The only thing which iritates me is
that :

/proc/ide/pdc202xx reports that the drives run in UDMA4 mode.

I have the above mentioned drives running as master each as a single
drive on its interface. 

How can I achive that the drives run in UDMA5 ?

Otto



