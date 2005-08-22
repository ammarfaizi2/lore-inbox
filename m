Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbVHVWLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbVHVWLn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbVHVWLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:11:42 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:53638 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751219AbVHVWL3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:11:29 -0400
Subject: Re: IRQ problem with PCMCIA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: David Hinds <dhinds@sonic.net>, "Hesse, Christian" <mail@earthworm.de>,
       linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
In-Reply-To: <58cb370e05082203325eb55c03@mail.gmail.com>
References: <200508212043.58331.mail@earthworm.de>
	 <20050821221739.GA18925@sonic.net> <20050821221935.GB18925@sonic.net>
	 <1124671082.1101.0.camel@localhost.localdomain>
	 <58cb370e050822022556595fa1@mail.gmail.com>
	 <1124706770.7281.13.camel@localhost.localdomain>
	 <58cb370e05082203325eb55c03@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 22 Aug 2005 12:30:15 +0100
Message-Id: <1124710216.7281.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-08-22 at 12:32 +0200, Bartlomiej Zolnierkiewicz wrote:
> I'll keep trying you can keep whining.

Actually I'm rather busy porting the old ATA drivers over to the new
SATA layer right now. HPT and VIA will be nasty to do but the simpler
drivers are moving over quite nicely. 

Now back to ata_serverworks.c

