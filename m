Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131069AbRBLVie>; Mon, 12 Feb 2001 16:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131231AbRBLViZ>; Mon, 12 Feb 2001 16:38:25 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:17157 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131069AbRBLVhx>; Mon, 12 Feb 2001 16:37:53 -0500
Subject: Re: Linux 2.2.19pre10:x!
To: cowboy@vnet.ibm.com (Richard A Nelson)
Date: Mon, 12 Feb 2001 21:38:35 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0102121329410.22778-100000@badlands.lexington.ibm.com> from "Richard A Nelson" at Feb 12, 2001 01:33:50 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14SQgA-00089o-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ah, but it does matter !  We break compatibility with other systems (and
> our manpages, and possibly standards) if we don't mark the segment
> IPC_PRIVATE upon removal -

This being so midbogglingly critical a bug that nobody noticed until 2.2.18
and the bug existed since 1.2 or earlier. I think I can wait for 2.2.20

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
