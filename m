Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270218AbTGMK5Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 06:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270219AbTGMK5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 06:57:24 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:26301
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270218AbTGMK5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 06:57:24 -0400
Subject: Re: hang with pcmcia wlan card
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Jaakko Niemi <liiwi@lonesom.pp.fi>, Wiktor Wodecki <wodecki@gmx.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030713120040.C2621@flint.arm.linux.org.uk>
References: <87fzldxcf5.fsf@jumper.lonesom.pp.fi>
	 <873chbyasi.fsf@jumper.lonesom.pp.fi>
	 <20030712173039.A17432@flint.arm.linux.org.uk>
	 <20030712164855.GB2133@gmx.de>
	 <1058086011.31919.39.camel@dhcp22.swansea.linux.org.uk>
	 <87wuemg3h2.fsf@jumper.lonesom.pp.fi>
	 <20030713110016.A2621@flint.arm.linux.org.uk>
	 <87he5qg0sp.fsf@jumper.lonesom.pp.fi>
	 <20030713120040.C2621@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058094571.32492.5.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Jul 2003 12:09:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-07-13 at 12:00, Russell King wrote:
> However, the patch to ti113x.h came from 2.4-ac, and afaik there haven't
> been any reports of failure there.  Also note that I was just the middle
> man in getting the original patch applied.

It took a while for the few laptops it bites to turn up. The new fix is
in the newest -ac build tree and seems to fix the cases I've tested

