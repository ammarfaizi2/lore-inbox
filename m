Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261924AbREMVoC>; Sun, 13 May 2001 17:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261927AbREMVnv>; Sun, 13 May 2001 17:43:51 -0400
Received: from hera.cwi.nl ([192.16.191.8]:53134 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S261922AbREMVnk>;
	Sun, 13 May 2001 17:43:40 -0400
Date: Sun, 13 May 2001 23:43:34 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200105132143.XAA39600.aeb@vlet.cwi.nl>
To: James.Bottomley@HansenPartnership.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [NEW SCSI DRIVER] for 53c700 chip and NCR_D700 card against 2.4.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> New SCSI driver for 53c700 chip

Good!

If I am not mistaken, Richard Hirst has also done work on this thing.

The Panther/lp486e/PWS/... has on-board ethernet (82596)
and this now works under both 2.2 and 2.4.
It also has on-board SCSI (NCR 53c700-66), maybe memory mapped,
I forget. Maybe nobody knows the addresses.
It would be somewhat interesting to get that thing to work as well.

Andries
