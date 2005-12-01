Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751721AbVLAUpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721AbVLAUpb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 15:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbVLAUpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 15:45:31 -0500
Received: from fsmlabs.com ([168.103.115.128]:52623 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S1751720AbVLAUpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 15:45:30 -0500
X-ASG-Debug-ID: 1133469928-4071-31-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Thu, 1 Dec 2005 12:51:08 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>
X-ASG-Orig-Subj: Re: [PATCH] x86_64: Display HPET timer option
Subject: Re: [PATCH] x86_64: Display HPET timer option
In-Reply-To: <Pine.LNX.4.64.0512011216200.13220@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.64.0512011251000.13220@montezuma.fsmlabs.com>
References: <Pine.LNX.4.64.0512011143350.13220@montezuma.fsmlabs.com>
 <Pine.LNX.4.64.0512011150110.3099@g5.osdl.org>
 <Pine.LNX.4.64.0512011216200.13220@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.5766
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Dec 2005, Zwane Mwaikambo wrote:

> On Thu, 1 Dec 2005, Linus Torvalds wrote:
> 
> > 
> > 
> > On Thu, 1 Dec 2005, Zwane Mwaikambo wrote:
> > >
> > > Currently the HPET timer option isn't visible in menuconfig.
> > 
> > Do you want it to?
> > 
> > Why would you ever compile it out?
> 
> For timer testing purposes i sometimes would like not to use the HPET. 
> Would a runtime switch be preferred?

I meant boottime of course.
