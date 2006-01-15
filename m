Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWAOSua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWAOSua (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 13:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWAOSua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 13:50:30 -0500
Received: from pb142.tychy.sdi.tpnet.pl ([217.96.251.142]:30883 "EHLO
	daper.net") by vger.kernel.org with ESMTP id S1750782AbWAOSu3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 13:50:29 -0500
Date: Sun, 15 Jan 2006 19:50:25 +0100
From: Damian Pietras <daper@daper.net>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with eject and pktcdvd
Message-ID: <20060115185025.GA15782@daper.net>
References: <20060115123546.GA21609@daper.net> <43CA8C15.8010402@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43CA8C15.8010402@cfl.rr.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2006 at 12:53:25PM -0500, Phillip Susi wrote:
> I am currently working on improving the udftools package in ubuntu to 
> make it actually usable.  In its current state it is only suitable for 
> experimentation.  See the thread titled "[PATCH] pktcdvd & udf bugfixes" 
> on this mailing list for more information.
> 
> Eject works fine for me though so I'm not sure what the problem is.  You 
> might want to try using the stock 2.6.12 breezy kernel on your breezy 
> install, instead of your home built 2.6.15-mm kernel.  I'm running the 
> stock 2.6.15 kernel on my dapper install and eject works just fine once 
> unmounted.

Neither Ubuntu kernel nor this patch fixes the problem.

>
> If you feel like building the package and testing it, it's up on REVU
> right now at http://revu.tauware.de/details.py?upid=1433

This is just updated udftools package? I don't think it's a userspace
problem. It happens also for CD-Rs with iso9660 filesystem.

-- 
Damian Pietras
