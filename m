Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132928AbRA2QYW>; Mon, 29 Jan 2001 11:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135184AbRA2QYM>; Mon, 29 Jan 2001 11:24:12 -0500
Received: from KZSU.Stanford.EDU ([171.66.118.90]:24580 "EHLO
	kzsu.stanford.edu") by vger.kernel.org with ESMTP
	id <S132928AbRA2QYE>; Mon, 29 Jan 2001 11:24:04 -0500
Date: Mon, 29 Jan 2001 08:24:03 -0800 (PST)
From: Romain Kang <romain@kzsu.stanford.edu>
Message-Id: <200101291624.IAA74849@kzsu.stanford.edu>
To: linux-kernel@vger.kernel.org
Subject: eepro100 - Linux vs. FreeBSD
Reply-To: romain@kzsu.stanford.edu
Organization: KZSU 90.1 FM, Stanford, Calif. USA
X-Newsreader: NN version 6.5.3 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dumb question:

I've been following the freebsd-hackers list for a while, and in
that domain, the Intel NICs are the preferred interfaces because
they perform well and are very stable.

One approach to the endless eepro100 headaches would be to port
the FreeBSD if_fxp driver to Linux.  After all, drivers have been
ported between these OSs before; e.g., the aic7xxx SCSI adapter.
However, I see no evidence that this has been attempted.  Can
someone tell me what I'm obviously missing?

Romain Kang                             Disclaimer: I speak for myself alone,
romain@kzsu.stanford.edu                except when indicated otherwise.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
