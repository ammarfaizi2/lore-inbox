Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263778AbUGRL32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbUGRL32 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 07:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263795AbUGRL32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 07:29:28 -0400
Received: from web40303.mail.yahoo.com ([66.218.78.82]:43909 "HELO
	web40303.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263778AbUGRL31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 07:29:27 -0400
Message-ID: <20040718112926.3474.qmail@web40303.mail.yahoo.com>
Date: Sun, 18 Jul 2004 04:29:26 -0700 (PDT)
From: Adrian Sandor <aditsu@yahoo.com>
Subject: Re: disabling irq, nobody cared
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40FA5B05.9050905@portrix.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Jan Dittmer wrote:
> Adrian Sandor wrote:
> > hdb: dma_timer_expiry: dma status == 0x64
> > hdb: DMA interrupt recovery
> > hdb: lost interrupt
>
> Had the same problem last week. After some googling
> the solution was to 
> change the settings of the SATA port in BIOS to
> Enhanced Mode, SATA only.

Thanks, but I don't have any SATA disk; my BIOS IDE
settings are: Enhanced Mode, P-ATA only.
And my main problem seems to be the "disabling irq"
thing.

Regards,
Adrian


		
__________________________________
Do you Yahoo!?
Vote for the stars of Yahoo!'s next ad campaign!
http://advision.webevents.yahoo.com/yahoo/votelifeengine/

