Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVGPCQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVGPCQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 22:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVGPCQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 22:16:27 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:56313 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261200AbVGPCQZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 22:16:25 -0400
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1121180216.10199.13.camel@c-67-188-6-232.hsd1.ca.comcast.net>
References: <200507121223.10704.annabellesgarden@yahoo.de>
	 <20050712140251.GB18296@elte.hu>
	 <1121178339.10199.8.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <20050712142828.GA20798@elte.hu>
	 <1121178696.10199.11.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <20050712144645.GA21517@elte.hu>
	 <1121180216.10199.13.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Content-Type: text/plain
Organization: MontaVista
Date: Fri, 15 Jul 2005 19:11:20 -0700
Message-Id: <1121479880.21287.4.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-12 at 07:56 -0700, Daniel Walker wrote:
> On Tue, 2005-07-12 at 16:46 +0200, Ingo Molnar wrote:
> > * Daniel Walker <dwalker@mvista.com> wrote:
> > 
> > > I haven't tested it recently . This was on an older version of RT 
> > > though . I could try it if it's interesting ? Or do you think it's 
> > > already fixed?
> > 
> > it would be definitely interesting to see how robust the latest IO-APIC 
> > code is.
> 
> I'm sure you test that all the time, but I'll try it ..

I tried it, and it appears to be fixed in current RT ..

Daniel

