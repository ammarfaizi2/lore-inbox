Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030484AbWJCSlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030484AbWJCSlZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 14:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030478AbWJCSlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 14:41:24 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:47605 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S1030477AbWJCSk7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 14:40:59 -0400
Date: Tue, 3 Oct 2006 11:40:16 -0700
To: Hugh Dickins <hugh@veritas.com>
Cc: "John W. Linville" <linville@tuxdriver.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, jeff@garzik.org
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061003184016.GB17635@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at> <5a4c581d0610020221s7bf100f8q893161b7c8c492d2@mail.gmail.com> <1159807483.4067.150.camel@mindpipe> <20061003123835.GA23912@tuxdriver.com> <1159890876.20801.65.camel@mindpipe> <Pine.LNX.4.64.0610030916000.3952@g5.osdl.org> <20061003180543.GD23912@tuxdriver.com> <Pine.LNX.4.64.0610031923520.3328@blonde.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610031923520.3328@blonde.wat.veritas.com>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 07:31:08PM +0100, Hugh Dickins wrote:
> On Tue, 3 Oct 2006, John W. Linville wrote:
> > 
> > Today's news seems to indicate that at least the major distros are
> > already shipping the updated tools, or on the verge of shipping them.
> > The window of breakage for most users looks like it will be fairly
> > small, no matter what action taken.
> > 
> > The more we can clean-up the WE API, the easier it will be to implement
> > the cfg80211 WE compatibility layer intended for wireless-dev.
> > I think WE-21 makes things better in that respect.
> 
> Please correct me if I'm wrong: isn't it the case that a few of the
> distros are now coming out with wireless_tools.28 supporting WE-20,
> but current 2.6.18-git wireless drivers are WE-21, supported only
> by wireless_tools.29.pre10?
> 
> Hugh

	wireless_tools.28 do support WE-21. I'm not a fool.

	Jean
