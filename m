Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbTJXWjR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 18:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbTJXWjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 18:39:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:40588 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261376AbTJXWjQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 18:39:16 -0400
Date: Fri, 24 Oct 2003 15:39:07 -0700
From: Chris Wright <chrisw@osdl.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Chris Wright <chrisw@osdl.org>, Frank Cusack <fcusack@fcusack.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: cset #'s stable?
Message-ID: <20031024153907.D19313@osdlab.pdx.osdl.net>
References: <20031021091347.A7526@google.com> <20031021095209.A32703@osdlab.pdx.osdl.net> <20031024222054.GB972@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20031024222054.GB972@ip68-0-152-218.tc.ph.cox.net>; from trini@kernel.crashing.org on Fri, Oct 24, 2003 at 03:20:54PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Tom Rini (trini@kernel.crashing.org) wrote:
> FWIW, it's easy to go back and forth as well, bash (pure sh?) functions
> to do it:

<snipped useful shell funcs>

Nice.  I believe current bk lets you do bk changes -k -r<rev> to get key
from ChangeSet file (identical to bk prs -r -hnd:Key ChangeSet), and
echo key | bk key2rev ChangeSet to convert back.  Not much simpler, but
a little ;-)

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
