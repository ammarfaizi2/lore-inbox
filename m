Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbVIDBuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbVIDBuK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 21:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVIDBuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 21:50:10 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:30348 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S1750777AbVIDBuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 21:50:08 -0400
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Brand-new notebook useless with Linux...
In-Reply-To: <200509031859_MC3-1-A720-F705@compuserve.com>
References: <200509031859_MC3-1-A720-F705@compuserve.com>
Date: Sun, 4 Sep 2005 02:50:07 +0100
Message-Id: <E1EBje3-0002GW-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert <76306.1226@compuserve.com> wrote:

> SMBus

Is there anything on there that you actually want to talk to?

> Audio ("unknown codec")

snd-ati-atiixp ought to drive it - if it doesn't, that's probably a bug.

> Modem ("no codec available")

It's a winmodem. What were you expecting?

> Wireless

Broadcom won't release any specs.

> FlashMedia

TI won't release any specs. If you're especially nice to them, they may
give you a binary driver built against your kernel.

> SD/MMC

Ditto.

> Additionally, the system clock runs at 2x normal speed with PowerNow enabled.

http://bugzilla.kernel.org/show_bug.cgi?id=3927

> Am I stuck with running XP on this thing?

If you buy a machine with hardware produced by manufacturers that are
hostile to Linux, and you want to use that hardware, then yes. Don't do
that.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
