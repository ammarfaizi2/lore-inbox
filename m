Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262615AbVAUXpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262615AbVAUXpE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 18:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbVAUXou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 18:44:50 -0500
Received: from holomorphy.com ([66.93.40.71]:25518 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262610AbVAUXl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 18:41:27 -0500
Date: Fri, 21 Jan 2005 15:41:23 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Bryce Harrington <bryce@osdl.org>, dev@osdl.org,
       linux-kernel@vger.kernel.org, stp-devel@lists.sourceforge.net,
       ltp-list@lists.sourceforge.net, hanrahat@osdl.org
Subject: Re: Kernel Panic with LTP on 2.6.11-rc1 (was Re: LTP Results for 2.6.x and 2.4.x)
Message-ID: <20050121234123.GS8896@holomorphy.com>
References: <Pine.LNX.4.33.0501181540480.11396-100000@osdlab.pdx.osdl.net> <Pine.LNX.4.33.0501211058080.32650-100000@osdlab.pdx.osdl.net> <20050121153520.6a7c08dd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050121153520.6a7c08dd.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2005 at 03:35:20PM -0800, Andrew Morton wrote:
> I am unable to find the oops trace amongst all that stuff.  Help?
> (It would have been handy to include it in the bug report, actually)

There was no oops. The panic() in oom_kill.c was triggered.


-- wli
