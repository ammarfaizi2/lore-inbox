Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbWFTUSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWFTUSD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 16:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbWFTUSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 16:18:03 -0400
Received: from xenotime.net ([66.160.160.81]:3517 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750857AbWFTUSC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 16:18:02 -0400
Date: Tue, 20 Jun 2006 13:20:49 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Greg Lindahl <greg.lindahl@qlogic.com>
Cc: ak@suse.de, olson@unixfolk.com, discuss@x86-64.org, brice@myri.com,
       linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [discuss] Re: [RFC] Whitelist chipsets supporting MSI and check
 Hyper-transport capabilities
Message-Id: <20060620132049.ff5e6f67.rdunlap@xenotime.net>
In-Reply-To: <20060620200352.GJ1414@greglaptop.internal.keyresearch.com>
References: <fa.5FgZbVFZIyOdjQ3utdNvbqTrUq0@ifi.uio.no>
	<fa.URgTUhhO9H/aLp98XyIN2gzSppk@ifi.uio.no>
	<Pine.LNX.4.61.0606192237560.25433@osa.unixfolk.com>
	<200606200925.30926.ak@suse.de>
	<20060620200352.GJ1414@greglaptop.internal.keyresearch.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006 13:03:52 -0700 Greg Lindahl wrote:

> On Tue, Jun 20, 2006 at 09:25:30AM +0200, Andi Kleen wrote:
> 
> > So if there are any more MSI problems comming up IMHO it should be white list/disabled 
> > by default and only turn on after a long time when Windows uses it by default 
> > or something. Greg, do you agree?
> 
> You probably meant the other Greg, but the situation doesn't seem to
> be that bad. Brice's proposed whitelist covers almost all Opteron PCI
> Express servers.

Why "almost"?  What does a user do if his/hers is not covered?
Does it cover the 10 new models that are available tomorrow?
(hypothetical question)

> What is the list of things which are known to have problems? All
> PCI-X?  We can ask some more people with PCI-X MSI cards what works
> for them, i.e.  Mellanox.

---
~Randy
