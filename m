Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261935AbREMWo3>; Sun, 13 May 2001 18:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261936AbREMWoU>; Sun, 13 May 2001 18:44:20 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:39432 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261935AbREMWoN>; Sun, 13 May 2001 18:44:13 -0400
Subject: Re: [NEW SCSI DRIVER] for 53c700 chip and NCR_D700 card against 2.4.4
To: Andries.Brouwer@cwi.nl
Date: Sun, 13 May 2001 23:40:33 +0100 (BST)
Cc: James.Bottomley@HansenPartnership.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <UTC200105132143.XAA39600.aeb@vlet.cwi.nl> from "Andries.Brouwer@cwi.nl" at May 13, 2001 11:43:34 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14z4XR-00071u-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If I am not mistaken, Richard Hirst has also done work on this thing.

He did 53c710+. The 700 and 700/66 are much less capable devices.

According to http://www.murphy.nl/~ard/systems/pws/pws/node18.html
the NCR 53c700/66 is mapped at 0xCC0-0xCFF.

The system board id looks interesting too. I wonder if its related to
the mac address.. Sadly my box is dead so I cant poke

