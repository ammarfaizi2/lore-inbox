Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262586AbVAUXkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262586AbVAUXkl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 18:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbVAUXix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 18:38:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:55184 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262586AbVAUXdN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 18:33:13 -0500
Date: Fri, 21 Jan 2005 15:33:08 -0800
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Bryce Harrington <bryce@osdl.org>, dev@osdl.org,
       ltp-list@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       stp-devel@lists.sourceforge.net
Subject: Re: [Dev] Re: Kernel Panic with LTP on 2.6.11-rc1 (was Re: LTP Results for 2.6.x and 2.4.x)
Message-ID: <20050121153308.I24171@build.pdx.osdl.net>
References: <Pine.LNX.4.33.0501181540480.11396-100000@osdlab.pdx.osdl.net> <Pine.LNX.4.33.0501211058080.32650-100000@osdlab.pdx.osdl.net> <20050121153520.6a7c08dd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050121153520.6a7c08dd.akpm@osdl.org>; from akpm@osdl.org on Fri, Jan 21, 2005 at 03:35:20PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> Bryce Harrington <bryce@osdl.org> wrote:
> I am unable to find the oops trace amongst all that stuff.  Help?
> 
> (It would have been handy to include it in the bug report, actually)

Yes, it would.  Or at least some better granularity leading up to the
problem.  I ran growfiles locally on 2.6.11-rc-bk and didn't have any
problem.  Could you strace growfiles and see what it was doing when it
killed the machine?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
