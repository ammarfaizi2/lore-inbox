Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261403AbSJCXpA>; Thu, 3 Oct 2002 19:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261373AbSJCXpA>; Thu, 3 Oct 2002 19:45:00 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:29193 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S261403AbSJCXo7>; Thu, 3 Oct 2002 19:44:59 -0400
Date: Fri, 4 Oct 2002 00:50:23 +0100
From: John Levon <levon@movementarian.org>
To: Dave Jones <davej@codemonkey.org.uk>, Robert Love <rml@tech9.net>,
       Greg KH <greg@kroah.com>, kernel <linux-kernel@vger.kernel.org>
Subject: Re: export of sys_call_table
Message-ID: <20021003235022.GA82187@compsoc.man.ac.uk>
References: <20021003153943.E22418@openss7.org> <20021003221525.GA2221@kroah.com> <20021003222716.GB14919@suse.de> <1033684027.1247.43.camel@phantasy> <20021003233504.GA20570@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021003233504.GA20570@suse.de>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *17xFjb-000G2u-00*1PVvwOG9g.I* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2002 at 12:35:04AM +0100, Dave Jones wrote:

> Hrmmm, HEAD CVS from a few minutes ago still does.
> John's work on getting things done correctly for 2.6 doesn't
> change the fact that it's buggered on Red Hat's 2.4 kernel.
> Or does it ?

Right, it's buggered on Red Hat's kernel. Not really a problem; they
have a bugzilla and it's not big deal to redirect users there.

Actually what I'd really like is for the Red Hat people to backport the
patch. It shouldn't be too hard.

This doesn't change the situation for users on other 2.4 kernels, of
course. But sys_call_table is still there for them.

regards
john

-- 
"Me and my friends are so smart, we invented this new kind of art:
 Post-modernist throwing darts"
	- the Moldy Peaches
