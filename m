Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264664AbUEJMZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264664AbUEJMZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 08:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264663AbUEJMZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 08:25:58 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:37760 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S264664AbUEJMZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 08:25:54 -0400
Date: Mon, 10 May 2004 13:31:29 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200405101231.i4ACVTa7000421@81-2-122-30.bradfords.org.uk>
To: "Richard B. Johnson" <root@chaos.analogic.com>,
       Shobhit Mathur <shobhitmmathur@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0405100757470.28174@chaos>
References: <20040510113303.20724.qmail@web51003.mail.yahoo.com>
 <Pine.LNX.4.53.0405100757470.28174@chaos>
Subject: Re: PCI excessive retry error
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I mentioned a "broken bus" in the beginning. Some new
> PCI boards are not 5-volt tolerant. If you plug them into
> the PCI bus of some motherboards (Intel 865PE chipset),
> The Intel D865PERL, for one, the PCI/Bus will get blown.
> Same with the MS-6585 (648 MAX board). I blew up several
> boards by plugging 3.5 volt PCI cards into the 5 volt
> bus. According to the rules, it's supposed to work unless
> the PCI slots have "Cadium Yellow" or "Brilliant Blue"
> keying plugs (I kid you not, it's in the PCI specs).

So, did you actually plug the cards in to the wrong coloured slots, or
do you have a 3.5 volt-incompatible motherboard with a colour of slots
which suggests compatibility?

John.
