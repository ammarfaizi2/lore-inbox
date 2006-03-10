Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751811AbWCJQlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbWCJQlu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 11:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbWCJQlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 11:41:50 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:55244 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751811AbWCJQlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 11:41:49 -0500
Subject: Re: Revenge of the sysfs maintainer! (was Re: [PATCH 8 of 20]
	ipath - sysfs support for core driver)
From: Arjan van de Ven <arjan@infradead.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Greg KH <gregkh@suse.de>, Roland Dreier <rdreier@cisco.com>,
       rolandd@cisco.com, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <1142008574.29925.21.camel@serpentine.pathscale.com>
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
	 <1142008574.29925.21.camel@serpentine.pathscale.com>
Content-Type: text/plain
Date: Fri, 10 Mar 2006 17:41:39 +0100
Message-Id: <1142008900.2876.72.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-10 at 08:36 -0800, Bryan O'Sullivan wrote:
> On Fri, 2006-03-10 at 17:24 +0100, Arjan van de Ven wrote:
> 
> > well shipping one .ko or two .ko's... same difference. Or maybe in your
> > case it's a 4->5 transition. No Difference from a user point of view.
> 
> I think you misunderstand.  The goal is for *us* to ship *none* :-)

then it gets easier.. KConfig lets you select debugfs. Done. 


