Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271690AbRHUONH>; Tue, 21 Aug 2001 10:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271691AbRHUOMq>; Tue, 21 Aug 2001 10:12:46 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:53009 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271690AbRHUOMn>; Tue, 21 Aug 2001 10:12:43 -0400
Subject: Re: Qlogic/FC firmware
To: davem@redhat.com (David S. Miller)
Date: Tue, 21 Aug 2001 15:15:20 +0100 (BST)
Cc: jes@sunsite.dk, linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "David S. Miller" at Aug 21, 2001 06:39:00 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZCJM-0007w6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You might as well remove all of these drivers in whole, as they are
> basically non-functional without the accompanying firmware.

Now you are talking complete and total crap. I tested this firmware removal
stuff on a QlogicFC 2100 card. It works fine and I am now getting to use
the qualified firmware in the BIOS flash not the unqualified firmware in
the kernel.

Alan
