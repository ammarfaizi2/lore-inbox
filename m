Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280953AbRKOR00>; Thu, 15 Nov 2001 12:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280954AbRKOR0H>; Thu, 15 Nov 2001 12:26:07 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:51469 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280953AbRKOR0D>; Thu, 15 Nov 2001 12:26:03 -0500
Subject: Re: CS423x audio driver updates for testing
To: jdthood@mail.com (Thomas Hood)
Date: Thu, 15 Nov 2001 17:28:23 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1005832507.26175.28.camel@thanatos> from "Thomas Hood" at Nov 15, 2001 08:55:06 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E164QJM-0000y2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Can folks with cs42xx series audio give it a test make sure it
> > doesn't break anything
> 
> Alan: Should I check to see whether these changes need to be ported
> to ALSA?

I think ALSA is already way ahead on the CS42xx series chips but sure
check by all means.

> By the way: In your opinion, is ALSA going to get into Linux 2.5?

Something like it I hope - I delegated that question to Zab and Jeff
