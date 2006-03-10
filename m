Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751805AbWCJQZB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbWCJQZB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 11:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751811AbWCJQZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 11:25:01 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:7130 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751805AbWCJQZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 11:25:00 -0500
Subject: Re: Revenge of the sysfs maintainer! (was Re: [PATCH 8 of 20]
	ipath - sysfs support for core driver)
From: Arjan van de Ven <arjan@infradead.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Greg KH <gregkh@suse.de>, Roland Dreier <rdreier@cisco.com>,
       rolandd@cisco.com, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <1142006121.29925.5.camel@serpentine.pathscale.com>
References: <ef8042c934401522ed3f.1141922821@localhost.localdomain>
	 <adapskvfbqe.fsf@cisco.com>
	 <1141947143.10693.40.camel@serpentine.pathscale.com>
	 <20060310003513.GA17050@suse.de>
	 <1141951589.10693.84.camel@serpentine.pathscale.com>
	 <20060310010050.GA9945@suse.de>
	 <1141966693.14517.20.camel@camp4.serpentine.com>
	 <1141977431.2876.18.camel@laptopd505.fenrus.org>
	 <1141998702.28926.15.camel@localhost.localdomain>
	 <1141999569.2876.47.camel@laptopd505.fenrus.org>
	 <1142006121.29925.5.camel@serpentine.pathscale.com>
Content-Type: text/plain
Date: Fri, 10 Mar 2006 17:24:52 +0100
Message-Id: <1142007892.2876.66.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-10 at 07:55 -0800, Bryan O'Sullivan wrote:
> On Fri, 2006-03-10 at 15:06 +0100, Arjan van de Ven wrote:
> 
> > > They mightn't be exactly today's kernels, but they're no more than two
> > > or three weeks old.  CONFIG_DEBUG_FS has been in the kernel for a long
> > > time, and it's still not being picked up.
> > 
> > but it's a module; you can ship it no problem yourself if you go through
> > the hell of shipping external modules
> 
> Yes, we can ship it ourselves.  But a significant point of this exercise
> is to have the drivers be available to people who use unmodified
> distros, and don't want to download other bits to do so.

well shipping one .ko or two .ko's... same difference. Or maybe in your
case it's a 4->5 transition. No Difference from a user point of view.


So sorry I'm not buying your argument very much.



