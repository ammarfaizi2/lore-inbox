Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbWATUUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWATUUX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 15:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWATUUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 15:20:23 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:35265 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932163AbWATUUW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 15:20:22 -0500
Subject: Re: BUG in check_monotonic_clock()
From: john stultz <johnstul@us.ibm.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: george@wildturkeyranch.net, mingo@elte.hu, linux-kernel@vger.kernel.org,
       tglx@linutronix.de
In-Reply-To: <1137784987.3202.14.camel@localhost.localdomain>
References: <1137779515.3202.3.camel@localhost.localdomain>
	 <1137782296.27699.253.camel@cog.beaverton.ibm.com>
	 <1137782896.3202.9.camel@localhost.localdomain>
	 <1137783149.27699.256.camel@cog.beaverton.ibm.com>
	 <1137783751.3202.11.camel@localhost.localdomain>
	 <1137784177.27699.260.camel@cog.beaverton.ibm.com>
	 <1137784987.3202.14.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 20 Jan 2006 12:20:18 -0800
Message-Id: <1137788418.27699.262.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-20 at 11:23 -0800, Daniel Walker wrote:
> Great! The patch that George sent me fixed it .. Thanks George !

Good to hear!

George, mind sending that patch to Andrew?

thanks
-john


