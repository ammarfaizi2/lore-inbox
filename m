Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129507AbRADKoJ>; Thu, 4 Jan 2001 05:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129771AbRADKn7>; Thu, 4 Jan 2001 05:43:59 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:20237
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129507AbRADKnr>; Thu, 4 Jan 2001 05:43:47 -0500
Date: Thu, 4 Jan 2001 02:43:33 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
Subject: WOOHOO!!!!!! IDEDMA Timeouts!!
Message-ID: <Pine.LNX.4.10.10101040240080.32298-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a 95% solution that prevents that hang.
It invokes some other minor kernel bugs because of the hack, but it
recovers ad keeps on trucking.

I now have to fine tune the NASTY-ARSE-HACK and test for
possible corruption, but it looks like none to be found do date.

Cheers,

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
