Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268375AbRGXRRw>; Tue, 24 Jul 2001 13:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268374AbRGXRRm>; Tue, 24 Jul 2001 13:17:42 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:40201 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268368AbRGXRRg>; Tue, 24 Jul 2001 13:17:36 -0400
Subject: Re: 2.4.7 cyclades-Y crash
To: kas@informatics.muni.cz (Jan Kasprzak)
Date: Tue, 24 Jul 2001 18:17:32 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010724190103.J1033@informatics.muni.cz> from "Jan Kasprzak" at Jul 24, 2001 07:01:03 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15P5oK-0000Vs-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> connected to 16-port box). The 2.4.7 kernel crashes when initializing the
> cyclades driver (either as a module or a built-in driver). I've tried
> the stock kernel from Red Hat 7.1, and the cyclades.o module causes the
> system to lock up when loaded.

Is this an SMP box ?

