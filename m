Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbTJWTyL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 15:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbTJWTyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 15:54:10 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:33244 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261748AbTJWTwy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 15:52:54 -0400
Subject: Re: 2.6.0-test8 mad clock rate drifts and sleeping function ...
From: john stultz <johnstul@us.ibm.com>
To: Roland Lezuo <roland.lezuo@chello.at>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200310231044.46668.roland.lezuo@chello.at>
References: <200310231044.46668.roland.lezuo@chello.at>
Content-Type: text/plain
Organization: 
Message-Id: <1066938672.1119.85.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 23 Oct 2003 12:51:13 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-23 at 01:44, Roland Lezuo wrote:

> I expirience enormous clock rates dirft since using 2.6.0-test8 (upgrade from 
> 2.4) I can even hear it when xmms is playing a song it suddenlty speed up to 
> 200% of normal speed, then normal speed for a while, then too slow for a 
> while...

> And after just 12h of running system time was wrong by 12h, but I'm not 
> absoluty sure about this (time is not running away while writing this).


So you're seeing time run twice as fast overall? Are you running with
NTP?  Do you have any sort of hardware power management on the system? 
Do you have any more details about the system? 

thanks
-john


