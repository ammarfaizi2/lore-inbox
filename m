Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbWFPDft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWFPDft (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 23:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbWFPDfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 23:35:48 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:5067 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750991AbWFPDfs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 23:35:48 -0400
Subject: Re: clocksource
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1150428084.15267.74.camel@cog.beaverton.ibm.com>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	 <Pine.LNX.4.64.0606050141120.17704@scrub.home>
	 <1149538810.9226.29.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0606052226150.32445@scrub.home>
	 <1149622955.4266.84.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.64.0606070005550.32445@scrub.home>
	 <1149753904.2764.24.camel@leatherman>
	 <Pine.LNX.4.64.0606151319440.32445@scrub.home>
	 <1150428084.15267.74.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 15 Jun 2006 20:35:45 -0700
Message-Id: <1150428945.15267.86.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-15 at 20:21 -0700, john stultz wrote:
> Very cool. I appreciate the small incremental patches. I've looked over
> them and am trying to see which ones make sense in light of the
> following info.

Ah, forgot to mention that the patch included the changes from your p1
fix (some of which I had already made, but items like the
clocksource_adj() name change is a clear improvement).

And just to be sure you know I'm not brushing your patches off: I'm
looking at patches p2, p4, p5 and p7 as the next steps, and after I get
some feedback on the patch I just sent we can discuss p3,p6, and p8.

Sound good?

thanks
-john

