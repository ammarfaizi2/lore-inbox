Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129793AbQKUMFj>; Tue, 21 Nov 2000 07:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130177AbQKUMFT>; Tue, 21 Nov 2000 07:05:19 -0500
Received: from ife.ee.ethz.ch ([129.132.29.2]:26822 "EHLO ife.ee.ethz.ch")
	by vger.kernel.org with ESMTP id <S129793AbQKUMFQ>;
	Tue, 21 Nov 2000 07:05:16 -0500
Message-ID: <3A1A5DEE.BCA32964@ife.ee.ethz.ch>
Date: Tue, 21 Nov 2000 12:35:10 +0100
From: Thomas Sailer <sailer@ife.ee.ethz.ch>
Organization: IfE
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: de,fr,ru
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: test11-pre6 still very broken
In-Reply-To: <Pine.LNX.4.21.0011171935560.1796-100000@saturn.homenet> <20001117223137.A26341@wirex.com> <3A162EFE.A980A941@talontech.com> <20001117235624.B26341@wirex.com> <8v6h3d$rp$1@penguin.transmeta.com> <3A191B03.6DE258C8@ife.ee.ethz.ch> <20001120134708.A941@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

> Oops? I thought the paired controller there is for OSes not being able
> to handle EHCI yet? So that USB works even for those ... I think EHCI
> should handle even 1.x devices ... I may be wrong, though.

Check the Intel EHCI spec. Esp. the chapter about port handover...

Tom
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
