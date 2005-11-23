Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030267AbVKWALt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbVKWALt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 19:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030270AbVKWALt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 19:11:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61387 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030267AbVKWALs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 19:11:48 -0500
Date: Tue, 22 Nov 2005 16:10:50 -0800
From: Chris Wright <chrisw@osdl.org>
To: Krzysztof Oledzki <ole@ans.pl>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Harald Welte <laforge@netfilter.org>,
       Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [patch 13/23] [PATCH] [NETFILTER] ctnetlink: Fix oops when no ICMP ID info in message
Message-ID: <20051123001050.GO5856@shell0.pdx.osdl.net>
References: <20051122205223.099537000@localhost.localdomain> <20051122210804.GN28140@shell0.pdx.osdl.net> <Pine.LNX.4.64.0511230023310.15479@bizon.gios.gov.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511230023310.15479@bizon.gios.gov.pl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Krzysztof Oledzki (ole@ans.pl) wrote:
> On Tue, 22 Nov 2005, Chris Wright wrote:
> 
> >-stable review patch.  If anyone has any objections, please let us know.
> 
> It seems we have two different patches here.

Thanks, you are right.  Harald, was that intentional?

thanks,
-chris
