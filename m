Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbVBHVvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbVBHVvP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 16:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbVBHVvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 16:51:15 -0500
Received: from palrel11.hp.com ([156.153.255.246]:27086 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S261672AbVBHVvN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 16:51:13 -0500
Date: Tue, 8 Feb 2005 13:51:12 -0800
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4] Wireless Extension v17 (resend)
Message-ID: <20050208215112.GB3290@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20050208181637.GB29717@bougret.hpl.hp.com> <20050208180116.GA10695@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050208180116.GA10695@logos.cnet>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2005 at 04:01:16PM -0200, Marcelo Tosatti wrote:
> 
> Hi Jean,
> 
> I'm very ignorant about wireless but it doesnt appear to me that "Wireless Extension v17"
> is a critical feature.

	You are right, it's not critical, and I was already thinking
of not pushing WE-18 to you (the WPA update). I'll stop updating 2.4.X
with respect to wireless, the patches will be available on my web page
for people who needs it. We may revisit this if there is a public
outcry...

> It seems more appropriate to declare it as 2.6 functionality ?

	There need to be some unique features in 2.6.X to force people
to upgrade, I guess...

> Cheers

	Thanks.

	Jean
