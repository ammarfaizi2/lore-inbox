Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbUGQUlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbUGQUlH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 16:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbUGQUlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 16:41:07 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:4482 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261682AbUGQUlF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 16:41:05 -0400
Date: Sat, 17 Jul 2004 22:41:04 +0200
From: bert hubert <ahu@ds9a.nl>
To: Ed Sweetman <safemode@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: audio cd writing causes massive swap and crash
Message-ID: <20040717204104.GA561@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Ed Sweetman <safemode@comcast.net>, linux-kernel@vger.kernel.org
References: <40F9854D.2000408@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40F9854D.2000408@comcast.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 17, 2004 at 04:00:13PM -0400, Ed Sweetman wrote:
> Both with 2.6.7-rc3 and 2.6.8-rc1-mm1 I get the same behavior when 
> writing an audio cd on my plextor px-712a.  DMA is enabled and normal 
> data cds write as expected, but audio cds will cause (at any speed) the 
> box to start using insane amounts of swap (>150MB) and eventually cause 
> the box to crash before finishing the cd.  CPU usage during the write is 

Can you run vmstat 1 during the burn and show us the output?

Thanks.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
