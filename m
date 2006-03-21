Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbWCUH3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWCUH3F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 02:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbWCUH3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 02:29:04 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:15574 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S932196AbWCUH3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 02:29:01 -0500
Date: Tue, 21 Mar 2006 08:28:59 +0100
From: Sander <sander@humilis.net>
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, sander@humilis.net,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, lkml@rtr.ca
Subject: Re: Some sata_mv error messages
Message-ID: <20060321072859.GB4089@favonius>
Reply-To: sander@humilis.net
References: <20060318044056.350a2931.akpm@osdl.org> <20060320133318.GB32762@favonius> <441F508E.1030008@pobox.com> <441F8599.7080703@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <441F8599.7080703@rtr.ca>
X-Uptime: 08:11:49 up 18 days, 12:22, 33 users,  load average: 4.25, 3.61, 3.11
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote (ao):
> Jeff Garzik wrote:
> >For now, the goal is a system that doesn't crash and doesn't corrupt 
> >data. If its occasionally slow or spits out a few errors, but
> >otherwise still works, that's pretty darned good :)
> 
> I'm currently working with the original authors of sata_mv, and have
> taken over maintenance of it for now. It should progress from "highly
> experimental" to "production quality" over the next month or so.

Thanks a lot :-)

> The (mucho) updated driver I'm using here now is already much improved
> in many ways. At some point, I'll break it out into patches for Jeff.
> 
> But there's one MAJOR bugfix patch that I'll release here shortly, to
> go with the interrupt handler fix already posted.

I've actually a patched kernel ready to test your patch. Only need to
boot the server, so will do that this afternoon and report back.

	Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
