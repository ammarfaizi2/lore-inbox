Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbWCJQgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWCJQgQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 11:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWCJQgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 11:36:16 -0500
Received: from mx.pathscale.com ([64.160.42.68]:48083 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751488AbWCJQgP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 11:36:15 -0500
Subject: Re: Revenge of the sysfs maintainer! (was Re: [PATCH 8 of 20]
	ipath - sysfs support for core driver)
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Greg KH <gregkh@suse.de>, Roland Dreier <rdreier@cisco.com>,
       rolandd@cisco.com, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <1142007892.2876.66.camel@laptopd505.fenrus.org>
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
	 <1142007892.2876.66.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Fri, 10 Mar 2006 08:36:14 -0800
Message-Id: <1142008574.29925.21.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-10 at 17:24 +0100, Arjan van de Ven wrote:

> well shipping one .ko or two .ko's... same difference. Or maybe in your
> case it's a 4->5 transition. No Difference from a user point of view.

I think you misunderstand.  The goal is for *us* to ship *none* :-)

Anyway, I think we have a few different possible workable solutions that
are not netlink, so I'm happy.

	<b

