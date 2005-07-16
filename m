Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261738AbVGPRMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbVGPRMu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 13:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbVGPRMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 13:12:36 -0400
Received: from mx1.elte.hu ([157.181.1.137]:16003 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261741AbVGPRMJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 13:12:09 -0400
Date: Sat, 16 Jul 2005 19:11:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
Message-ID: <20050716171126.GA16235@elte.hu>
References: <200507121223.10704.annabellesgarden@yahoo.de> <20050712140251.GB18296@elte.hu> <1121178339.10199.8.camel@c-67-188-6-232.hsd1.ca.comcast.net> <20050712142828.GA20798@elte.hu> <1121178696.10199.11.camel@c-67-188-6-232.hsd1.ca.comcast.net> <20050712144645.GA21517@elte.hu> <1121180216.10199.13.camel@c-67-188-6-232.hsd1.ca.comcast.net> <1121479880.21287.4.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121479880.21287.4.camel@dhcp153.mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> On Tue, 2005-07-12 at 07:56 -0700, Daniel Walker wrote:
> > On Tue, 2005-07-12 at 16:46 +0200, Ingo Molnar wrote:
> > > * Daniel Walker <dwalker@mvista.com> wrote:
> > > 
> > > > I haven't tested it recently . This was on an older version of RT 
> > > > though . I could try it if it's interesting ? Or do you think it's 
> > > > already fixed?
> > > 
> > > it would be definitely interesting to see how robust the latest IO-APIC 
> > > code is.
> > 
> > I'm sure you test that all the time, but I'll try it ..
> 
> I tried it, and it appears to be fixed in current RT ..

cool, thanks.

	Ingo
