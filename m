Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264278AbUENFkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264278AbUENFkp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 01:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264297AbUENFko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 01:40:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:26784 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264278AbUENFkn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 01:40:43 -0400
Date: Thu, 13 May 2004 22:40:42 -0700
From: Chris Wright <chrisw@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: Chris Wright <chrisw@osdl.org>, Andy Lutomirski <luto@myrealbox.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] capabilities, take 3 (Re: [PATCH] capabilites, take 2)
Message-ID: <20040513224042.O21045@build.pdx.osdl.net>
References: <200405131308.40477.luto@myrealbox.com> <20040513182010.L21045@build.pdx.osdl.net> <200405131945.53723.luto@myrealbox.com> <20040513220415.E22989@build.pdx.osdl.net> <200405140532.i4E5WF4p006799@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200405140532.i4E5WF4p006799@turing-police.cc.vt.edu>; from Valdis.Kletnieks@vt.edu on Fri, May 14, 2004 at 01:32:15AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Valdis.Kletnieks@vt.edu (Valdis.Kletnieks@vt.edu) wrote:
> On Thu, 13 May 2004 22:04:15 PDT, Chris Wright said:
> 
> > Well, I wonder what IRIX does?  They support capabilities and had a
> > reasonable sized hand in the draft.  No point in making it impossible
> > to port apps.  It's not that I'm a strong fan of Posix caps, but
> > compatibility (even with a partially complete draft) with defacto
> > standards is not entirely unreasonable.
> 
> The IRIX 6.5 manpage says:

Thanks.

OK, this is precisely POSIX as I expected.  No surprise given the folks
involved.

<snip manpage>

> Note that Irix has *3* capability vectors attached to a file....

This is what POSIX specifies (with as much authority as a withdrawn spec
has ;-)

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
