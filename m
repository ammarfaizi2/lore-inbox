Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129414AbQLMCoF>; Tue, 12 Dec 2000 21:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129999AbQLMCnz>; Tue, 12 Dec 2000 21:43:55 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:20745 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129414AbQLMCni>; Tue, 12 Dec 2000 21:43:38 -0500
Subject: Re: 2.2.18pre21 oops reading /proc/apm
To: neale@lowendale.com.au (Neale Banks)
Date: Wed, 13 Dec 2000 02:14:02 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), sfr@linuxcare.com (Stephen Rothwell),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.05.10012131233210.27152-200000@marina.lowendale.com.au> from "Neale Banks" at Dec 13, 2000 01:01:43 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1461Qi-0002Bx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (3) modifies the output of /proc/apm when power status reporting is
> disabled - on reflection, maybe this wasn't such a smart thing to do
> (could royally stuff anybody who is automagically parsing /proc/apm?)

Please dont - it correctly reports 'dunno' right now

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
