Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274752AbRKDTaD>; Sun, 4 Nov 2001 14:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274368AbRKDT3y>; Sun, 4 Nov 2001 14:29:54 -0500
Received: from colorfullife.com ([216.156.138.34]:57614 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S274299AbRKDT3q>;
	Sun, 4 Nov 2001 14:29:46 -0500
Message-ID: <3BE59724.9EB3B816@colorfullife.com>
Date: Sun, 04 Nov 2001 20:29:40 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.14-pre7 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: John Fremlin <john@fremlin.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [POLITICAL] Re: ECS k7s5a audio sound SiS 735 - 7012
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Indeed. Could you all please hassle SiS for the datasheet for the 7012
> integrated audio controller in the SiS 735?

Sis is quite good at writing Linux drivers and they release the source
under GPL - just search through google for bug reports for the sis900
network driver. 

And it's probably the only driver with a large list of the PHY's that
are used by the mobo manufacturers with the nic, and the various ways to
get at the correct negotiation result. That's something you won't be
able to write even with the sis datasheet.

Just wait a bit, or try to convince nvidia that they should release the
source of their driver if you want to do something now.

--
	Manfred
