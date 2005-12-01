Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932547AbVLAXH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547AbVLAXH6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 18:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbVLAXH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 18:07:58 -0500
Received: from fsmlabs.com ([168.103.115.128]:5266 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S932547AbVLAXH5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 18:07:57 -0500
X-ASG-Debug-ID: 1133478475-13729-0-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Thu, 1 Dec 2005 15:13:35 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andi Kleen <ak@suse.de>
cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
X-ASG-Orig-Subj: Re: [PATCH] x86_64: Display HPET timer option
Subject: Re: [PATCH] x86_64: Display HPET timer option
In-Reply-To: <20051201204339.GC997@wotan.suse.de>
Message-ID: <Pine.LNX.4.64.0512011511290.13220@montezuma.fsmlabs.com>
References: <Pine.LNX.4.64.0512011143350.13220@montezuma.fsmlabs.com>
 <Pine.LNX.4.64.0512011150110.3099@g5.osdl.org>
 <Pine.LNX.4.64.0512011216200.13220@montezuma.fsmlabs.com>
 <20051201204339.GC997@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.5772
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Dec 2005, Andi Kleen wrote:

> On Thu, Dec 01, 2005 at 12:30:03PM -0800, Zwane Mwaikambo wrote:
> > On Thu, 1 Dec 2005, Linus Torvalds wrote:
> > 
> > > 
> > > 
> > > On Thu, 1 Dec 2005, Zwane Mwaikambo wrote:
> > > >
> > > > Currently the HPET timer option isn't visible in menuconfig.
> > > 
> > > Do you want it to?
> > > 
> > > Why would you ever compile it out?
> > 
> > For timer testing purposes i sometimes would like not to use the HPET. 
> > Would a runtime switch be preferred?
> 
> nohpet already exists.

Alright, my real intention was being able to change that by specifying 
seperate kernel configurations. It's not that pressing i can live with an 
external patch.

Thanks,
	Zwane

