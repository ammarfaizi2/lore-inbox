Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbTE1XD5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 19:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbTE1XD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 19:03:56 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:3077 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261603AbTE1XDj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 19:03:39 -0400
Date: Wed, 28 May 2003 19:11:02 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Pascal Schmidt <der.eremit@email.de>
cc: linux-kernel@vger.kernel.org, Willy Tarreau <willy@w.ods.org>
Subject: Re: Aix7xxx unstable in 2.4.21-rc2? (RE: Linux 2.4.21-rc2)
In-Reply-To: <E19JXTg-0000HO-00@neptune.local>
Message-ID: <Pine.LNX.3.96.1030528190927.21414F-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 May 2003, Pascal Schmidt wrote:

> On Fri, 23 May 2003 22:30:17 +0200, Willy Tarreau wrote in lkml:
> 
> > By this time, there will be more and more people leaving vanilla kernel for
> > their machines, and using them only as a base to apply -aa, -ac, -jam, -wolk,
> > -** + sf.net/* + who_knows_what, and I find it a shame.
> 
> I think you overestimate the number of aic7xxx users. It's not like
> 99% of all 2.4 users need the driver.

Conversely I would bet that somewhere >25% of all SCSI users need that
driver. It depends on how you want to look at it.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

