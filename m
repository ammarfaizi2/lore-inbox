Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945992AbWBCVvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945992AbWBCVvE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 16:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945996AbWBCVvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 16:51:03 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:52663 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1945992AbWBCVvC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 16:51:02 -0500
Subject: Re: [-mm patch] kernel/time/timeofday.c: make struct ts_interval
	static
From: john stultz <johnstul@us.ibm.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060203205716.GI4408@stusta.de>
References: <20060203000704.3964a39f.akpm@osdl.org>
	 <20060203205716.GI4408@stusta.de>
Content-Type: text/plain
Date: Fri, 03 Feb 2006 13:50:59 -0800
Message-Id: <1139003459.10057.133.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-03 at 21:57 +0100, Adrian Bunk wrote:
> On Fri, Feb 03, 2006 at 12:07:04AM -0800, Andrew Morton wrote:
> >...
> > Changes since 2.6.15-mm4:
> >...
> > +time-generic-timekeeping-infrastructure.patch
> >...
> >  Bring back John's time-reqork patches.  New, improved, fixed.
> >...
> 
> 
> This patch makes a needlessly global struct static.

Ah! Great catches on all three of these patches!

Acked-by: John Stultz <johnstul@us.ibm.com>


Thanks so much!
-john

