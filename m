Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129748AbRBCSIT>; Sat, 3 Feb 2001 13:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129567AbRBCSIJ>; Sat, 3 Feb 2001 13:08:09 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:41483 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129748AbRBCSH4>; Sat, 3 Feb 2001 13:07:56 -0500
Subject: Re: [BUG?] Unix Domain sockets in 2.4 series ?
To: maxikazz@loiv.torun.pl (Krzysztof Rusocki)
Date: Sat, 3 Feb 2001 18:08:35 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0102031844070.20382-100000@hetman> from "Krzysztof Rusocki" at Feb 03, 2001 07:04:19 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14P76z-0000BF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I only tried that  little code remotely so  i do NOT know
> what's system reaction on console ...
> 
> Anyway socket interface goes bye bye after this...

Fixed in 2.4.1-ac2
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
