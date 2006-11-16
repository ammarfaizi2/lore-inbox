Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424311AbWKPSjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424311AbWKPSjy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 13:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424309AbWKPSjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 13:39:54 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:57550 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1424304AbWKPSjx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 13:39:53 -0500
Date: Thu, 16 Nov 2006 10:38:47 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, netdev@vger.kernel.org, mb@bu3sch.de,
       greg@kroah.com, "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [patch 07/30] bcm43xx: Drain TX status before starting IRQs
Message-ID: <20061116183847.GE1397@sequoia.sous-sol.org>
References: <20061116024332.124753000@sous-sol.org> <20061116024511.458086000@sous-sol.org> <455C8D39.3080001@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455C8D39.3080001@lwfinger.net>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Larry Finger (Larry.Finger@lwfinger.net) wrote:
> We have a report of a regression between 2.6.19-rc3 and -rc5. As this patch 
> seems to be the only one that could cause the problem, please pull it from 
> -stable while we sort out the difficulty.

Thanks a lot for the heads up Larry, dropping this one.
-chris
