Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267766AbUJHF1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267766AbUJHF1S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 01:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267785AbUJHF1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 01:27:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:9911 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267766AbUJHF1R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 01:27:17 -0400
Date: Thu, 7 Oct 2004 22:27:13 -0700
From: Chris Wright <chrisw@osdl.org>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <piggin@cyberone.com.au>,
       nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       davej@codemonkey.org.uk
Subject: Re: kswapd in tight loop 2.6.9-rc3-bk-recent
Message-ID: <20041007222713.Y2357@build.pdx.osdl.net>
References: <4165E0A7.7080305@yahoo.com.au> <20041007174242.3dd6facd.akpm@osdl.org> <20041007184134.S2357@build.pdx.osdl.net> <20041007185131.T2357@build.pdx.osdl.net> <20041007185352.60e07b2f.akpm@osdl.org> <4165FF7B.1070302@cyberone.com.au> <20041007200109.57ce24ae.akpm@osdl.org> <416605CC.2080204@cyberone.com.au> <20041007203048.298029ab.akpm@osdl.org> <20041007222119.X2357@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041007222119.X2357@build.pdx.osdl.net>; from chrisw@osdl.org on Thu, Oct 07, 2004 at 10:21:19PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Wright (chrisw@osdl.org) wrote:
> * Andrew Morton (akpm@osdl.org) wrote:
> > Chris, do you have time to test this, against -linus?
> 
> Yeah.  This patch held up against the simple testing, as did Nick's (not
> the most recent combined one from him).

err, meaning:  I have not tested Nick's most recent combined patch.
