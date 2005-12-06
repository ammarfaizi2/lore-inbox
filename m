Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbVLFH3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbVLFH3K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 02:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbVLFH3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 02:29:10 -0500
Received: from legolas.otaku42.de ([217.24.0.78]:63905 "EHLO
	legolas.otaku42.de") by vger.kernel.org with ESMTP id S1750727AbVLFH3I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 02:29:08 -0500
Subject: Re: Broadcom 43xx first results
From: Michael Renzmann <netdev@nospam.otaku42.de>
Reply-To: netdev@nospam.otaku42.de
To: Jeff Garzik <jgarzik@pobox.com>
Cc: netdev@nospam.otaku42.de, Jiri Benc <jbenc@suse.cz>, mbuesch@freenet.de,
       linux-kernel@vger.kernel.org, bcm43xx-dev@lists.berlios.de,
       NetDev <netdev@vger.kernel.org>
In-Reply-To: <43948B13.2090509@pobox.com>
References: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de>
	 <20051205190038.04b7b7c1@griffin.suse.cz> <1133806444.4498.35.camel@gimli>
	 <43948B13.2090509@pobox.com>
Content-Type: text/plain
Date: Tue, 06 Dec 2005 08:17:58 +0100
Message-Id: <1133853478.4468.9.camel@gimli>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2005-12-05 at 13:46 -0500, Jeff Garzik wrote:
> > Although I'm a bit biased towards MadWifi, I'd second your suggestion to
> > make use of the Devicescape code. The benefit of having a fully-blown
> > 802.11 stack in the kernel that drivers can make use of has been
> > discussed before, so I won't go into that yet again.
> Use the stack that's already in the kernel.

Sorry, that was my bad. I thought that the Devicescape code found its
way to the kernel (didn't follow the discussion some months ago too
closely). Although I think there probably are better alternatives to the
802.11 stack that is in the kernel right now, having a central 802.11
stack at all is a great improvement that should be used where possible.

> Encouraging otherwise hinders continued wireless progress under Linux.

That depends. If the encouraging is about an alternative, more complete
and superior 802.11 stack for Linux which could be integrated with less
effort than extending the existing code, that should be worth to talk
about. 

Please note that I'm not refering here to any of the related suggestions
which have been made during the past months - it's a general statement.

Bye, Mike

