Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132026AbQLZUze>; Tue, 26 Dec 2000 15:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132046AbQLZUzY>; Tue, 26 Dec 2000 15:55:24 -0500
Received: from cx518206-b.irvn1.occa.home.com ([24.21.107.123]:7940 "EHLO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with ESMTP
	id <S132026AbQLZUzJ>; Tue, 26 Dec 2000 15:55:09 -0500
From: "Barry K. Nathan" <barryn@cx518206-b.irvn1.occa.home.com>
Message-Id: <200012262024.MAA01413@cx518206-b.irvn1.occa.home.com>
Subject: Re: Abysmal RAID 0 performance on 2.4.0-test10 for IDE?
To: root@mauve.demon.co.uk (Ian Stirling)
Date: Tue, 26 Dec 2000 12:24:08 -0800 (PST)
Cc: riel@conectiva.com.br (Rik van Riel), linux-kernel@vger.kernel.org
Reply-To: barryn@pobox.com
In-Reply-To: <200012261952.TAA11390@mauve.demon.co.uk> from "Ian Stirling" at Dec 26, 2000 07:52:55 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Stirling wrote:
> Where are you getting 100MB/s?
> The PCI bus can move around 130MB/sec, but RAM is lots faster.

I'll clarify your clarification further. :) Your typical PC has 33MHz
32-bit PCI. Increasing it to 66MHz or 64-bit can double the transfer rate,
and doing both can quadruple it. (Perhaps I've overlooked a detail or
oversimplified something, in which case I'd appreciate being corrected.)

-Barry K. Nathan <barryn@pobox.com>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
