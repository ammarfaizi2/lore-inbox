Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268700AbRGZWKS>; Thu, 26 Jul 2001 18:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268703AbRGZWKI>; Thu, 26 Jul 2001 18:10:08 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:26386 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268700AbRGZWJy>; Thu, 26 Jul 2001 18:09:54 -0400
Subject: Re: Proliant ML530, Megaraid 493 (Elite 1600), 2.4.7, timeout & abort
To: cro@ncacasi.org (C. R. Oldham)
Date: Thu, 26 Jul 2001 23:10:43 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "C. R. Oldham" at Jul 26, 2001 01:35:27 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15PtL9-0004bh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> the Elite 1600) in them. I am able to get them to boot with 2.2.19, but
> not 2.4.7.   Under 2.4.7 the relevant message is

Ok first thing - does 2.4.6 work. If so then  there is a bug or firmware
incompatibility with the firmware set you have and the newer driver.
