Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274584AbRITRm0>; Thu, 20 Sep 2001 13:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274581AbRITRmQ>; Thu, 20 Sep 2001 13:42:16 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:32780 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274580AbRITRmE>; Thu, 20 Sep 2001 13:42:04 -0400
Subject: Re: drivers/char/sonypi.h broken
To: rgooch@ras.ucalgary.ca (Richard Gooch)
Date: Thu, 20 Sep 2001 18:46:45 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <200109201418.f8KEIjG01625@vindaloo.ras.ucalgary.ca> from "Richard Gooch" at Sep 20, 2001 08:18:45 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15k7uP-0005im-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> in 12 hours. I think this just highlights the need for BitKeeper or
> equivalent, where automated regression testing (even a simple "does it
> compile and link?") is performed, and if the test fails, it gets
> bounced and doesn't even get to Linus.

I do compile/link tests but not a million combinations of them. Its
o(N!) remember..

