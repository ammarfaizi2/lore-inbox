Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131100AbRAERh3>; Fri, 5 Jan 2001 12:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132257AbRAERhT>; Fri, 5 Jan 2001 12:37:19 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:58374 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131100AbRAERhP>; Fri, 5 Jan 2001 12:37:15 -0500
Subject: Re: 2.4.0 LVM
To: samkaski@cs.Helsinki.FI (Samuli Kaski)
Date: Fri, 5 Jan 2001 17:38:39 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0101051932420.2773-100000@melkki.cs.Helsinki.FI> from "Samuli Kaski" at Jan 05, 2001 07:34:45 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Eap8-00087b-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> LVM doesn't compile without CONFIG_LVM_PROC_FS.

Fixed in -ac for ages. Linus didnt think it important enough for 2.4.0 - which
compared to 'it crashes when I..' is reasonable enough I think
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
