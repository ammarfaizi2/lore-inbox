Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbULXOgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbULXOgn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 09:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbULXOgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 09:36:43 -0500
Received: from xs4all.vs19.net ([213.84.236.198]:18743 "EHLO spaans.vs19.net")
	by vger.kernel.org with ESMTP id S261405AbULXOgm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 09:36:42 -0500
Date: Fri, 24 Dec 2004 15:36:40 +0100
From: Jasper Spaans <jasper@vs19.net>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: acct() ?
Message-ID: <20041224143640.GA24207@spaans.vs19.net>
References: <Pine.LNX.4.61.0412241431580.3707@dragon.hygekrogen.localhost> <Pine.LNX.4.33.0412241432210.31569-100000@muur.intranet.vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0412241432210.31569-100000@muur.intranet.vanheusden.com>
X-Copyright: Copyright 2004 Jasper Spaans, unauthorised distribution prohibited
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2004 at 02:33:45PM +0100, Folkert van Heusden wrote:

> Has the contents of the structures returned by acct() changed by any chance?
> (I mean: 2.6.9 being different from 2.4.26)

That depends on whether you've set CONFIG_BSD_PROCESS_ACCT_V3=y in your
configuration.

-- 
Jasper Spaans                                       http://jsp.vs19.net/
 15:30:15 up 10173 days,  7:17, 0 users, load average: 7.52 6.58 5.72
  -... .- -.. --. . .-. -... .- -.. --. . .-. -... .- -.. --. . .-.
