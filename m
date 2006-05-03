Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWECSjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWECSjp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 14:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWECSjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 14:39:45 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:4829 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S1750716AbWECSjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 14:39:45 -0400
Date: Wed, 3 May 2006 20:39:43 +0200
From: Sander <sander@humilis.net>
To: Mark Lord <liml@rtr.ca>
Cc: sander@humilis.net, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.xx: sata_mv: another critical fix
Message-ID: <20060503183943.GA31435@favonius>
Reply-To: sander@humilis.net
References: <20060321121354.GB24977@favonius> <Pine.LNX.4.64.0603211316580.3622@g5.osdl.org> <20060322090006.GA8462@favonius> <200603220950.11922.lkml@rtr.ca> <20060322170959.GA3222@favonius> <4428BCBF.2050000@pobox.com> <20060503121643.GA21882@favonius> <4458A52D.30100@rtr.ca> <20060503133239.GA11811@favonius> <4458DE81.6040603@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4458DE81.6040603@rtr.ca>
X-Uptime: 20:31:45 up 5 days, 36 min, 28 users,  load average: 4.94, 2.49, 1.76
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote (ao):
> Sander wrote:
> >The message "PCI ERROR; PCI IRQ cause=0x40000100" gives no result in
> >Google. Could this be a broken or miss-seated controller?
> 
> Yes. Those bits mean: "no target response within 4 PCI clock cycles".
> 
> In English, I believe the translation is "dead/disconnected controller".

Thank you for explaining the error and the translation. 

I'll try to re-seat it then, and replace it when that fails.

	With kind regards, Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
