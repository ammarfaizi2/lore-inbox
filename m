Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276150AbRJUPAx>; Sun, 21 Oct 2001 11:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276204AbRJUPAn>; Sun, 21 Oct 2001 11:00:43 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35344 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276150AbRJUPA3>; Sun, 21 Oct 2001 11:00:29 -0400
Subject: Re: MODULE_LICENSE and EXPORT_SYMBOL_GPL
To: kaos@ocs.com.au (Keith Owens)
Date: Sun, 21 Oct 2001 16:06:44 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <28610.1003559905@ocs3.intra.ocs.com.au> from "Keith Owens" at Oct 20, 2001 04:38:25 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15vKBY-0006cX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> and add that string to the non-tainting list.  BSD no advert code that
> is not in the kernel tree can either switch to dual BSD/GPL or be
> tainted, at the choice of the supplier.

BSD no advertising with no patent issues (and therefore compliant) linked
with GPL code ends up as GPL anyway, so I don't see the problem in using
the dual BSD/GPL tag

Alan
