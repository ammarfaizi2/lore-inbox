Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129104AbRBFKYK>; Tue, 6 Feb 2001 05:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129170AbRBFKYB>; Tue, 6 Feb 2001 05:24:01 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:57866 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129104AbRBFKXz>; Tue, 6 Feb 2001 05:23:55 -0500
Subject: Re: [OT] Why so much memory 'reserved'?
To: gandalf@winds.org (Byron Stanoszek)
Date: Tue, 6 Feb 2001 10:24:48 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0102051957540.1746-100000@winds.org> from "Byron Stanoszek" at Feb 05, 2001 08:41:17 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Q5Io-0005Jn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is an offtopic question. What determines the amount of 'reserved' memory,
> and how much to reserve?

The BIOS

> Is there a way I can 'regain' this memory from the system, especially in cases
> when there's only 32MB to work with?

In theory if ACPI isnt being used we can reclaim some of it on certain boxes
but I dont believe anyone has implemented that yet
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
