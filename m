Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbTKDSoP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 13:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbTKDSoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 13:44:15 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:59089 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262529AbTKDSoI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 13:44:08 -0500
Subject: Re: [PATCH] amd76x_pm on 2.6.0-test9 cleanup
From: john stultz <johnstul@us.ibm.com>
To: Tony Lindgren <tony@atomide.com>
Cc: lkml <linux-kernel@vger.kernel.org>, psavo@iki.fi, clepple@ghz.cc
In-Reply-To: <20031104002243.GC1281@atomide.com>
References: <20031104002243.GC1281@atomide.com>
Content-Type: text/plain
Organization: 
Message-Id: <1067971295.11436.66.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 04 Nov 2003 10:41:35 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-11-03 at 16:22, Tony Lindgren wrote:
> After a year of not having access to my dual athlon box I finally ran
> apt-get dist-upgrade on it :)
> 
> I also did some cleanup on the amd76x_pm to make the amd76x_pm to load as 
> module, and to remove some unnecessary PCI code.

I've received some reports that this patch causes time problems.

Have those issues been looked into further, or addressed? 

thanks
-john


