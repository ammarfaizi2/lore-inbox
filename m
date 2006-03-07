Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752016AbWCGHAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016AbWCGHAc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 02:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752078AbWCGHAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 02:00:32 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:32474
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1752016AbWCGHAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 02:00:31 -0500
Date: Mon, 06 Mar 2006 23:00:30 -0800 (PST)
Message-Id: <20060306.230030.131765838.davem@davemloft.net>
To: nickpiggin@yahoo.com.au
Cc: dipankar@in.ibm.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       fabbione@ubuntu.com, akpm@osdl.org
Subject: Re: VFS nr_files accounting
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <440D2DDA.7040209@yahoo.com.au>
References: <20060306.123904.35238417.davem@davemloft.net>
	<20060307064120.GA5946@in.ibm.com>
	<440D2DDA.7040209@yahoo.com.au>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Piggin <nickpiggin@yahoo.com.au>
Date: Tue, 07 Mar 2006 17:53:14 +1100

> The other thing that is typically done for regressions like these
> close to release time is to revert the offending changes. I figure
> that in this case, such an option is probably _more_ risky.

Especially since we're talking about something that went into
2.6.14
