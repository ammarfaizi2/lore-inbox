Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129776AbRAAW0f>; Mon, 1 Jan 2001 17:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130367AbRAAW0Z>; Mon, 1 Jan 2001 17:26:25 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:25097
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129776AbRAAW0O>; Mon, 1 Jan 2001 17:26:14 -0500
Date: Mon, 1 Jan 2001 13:55:26 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Ignore that part of the patch.....
Message-ID: <Pine.LNX.4.10.10101011351200.22396-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry about that, it was an undo that happened back at pre10 when the
correct changes were applied; however, we may rip it out if I can finish
the execute_diagnostics call to clear the PDIAG line and get the drive to
report the impedence decay to correctly address the bit13 of word 93.

For now it was a goof to an incomplete feature, but that was the only
goof I am aware of at this point.

Regards,

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
