Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266233AbUGOQUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266233AbUGOQUN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 12:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264633AbUGOQUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 12:20:13 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:57229 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S266233AbUGOQUI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 12:20:08 -0400
Subject: Re: Re[2]: tcp_window_scaling degrades performance
From: Kasper Sandberg <lkml@metanurb.dk>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <1982088034.20040715172517@dns.toxicfilms.tv>
References: <1956423367.20040715170937@dns.toxicfilms.tv>
	 <1089904911.15291.4.camel@localhost>
	 <1982088034.20040715172517@dns.toxicfilms.tv>
Content-Type: text/plain
Date: Thu, 15 Jul 2004 18:20:07 +0200
Message-Id: <1089908408.15291.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-15 at 17:25 +0200, Maciej Soltysiak wrote:
> KS> hey, are you having some kind of hardware router?
> Well, there is a hardware router, 3com but it's a local router,
> the router that sends the traffic to the Internet link is a checkpoint
> firewall-1 on running on linux.
> 
> I have 2 linux-2.6 machines, this weird behaviour is only with them.
yes, but its not linux that behaves wrong, if you actually do have a
hardware router, its probably the router doing wrong. changing to linux
router and it works :)
> 
> Regards,
> Maciej
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

