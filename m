Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264482AbTEJTK0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 15:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264483AbTEJTK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 15:10:26 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:21385 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S264482AbTEJTKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 15:10:24 -0400
Date: Sat, 10 May 2003 15:23:03 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: kernel.bkbits.net and BK->CVS gateway
Message-ID: <20030510192253.GA24276@delft.aura.cs.cmu.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030510154352.GK679@phunnypharm.org> <20030510162207.GB24686@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030510162207.GB24686@work.bitmover.com>
User-Agent: Mutt/1.5.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 10, 2003 at 09:22:07AM -0700, Larry McVoy wrote:
> In other words, I think you're safe.  Famous last words, we'll now discover
> that our friends in .cz have written the world's first BK virus and it 
> corrupts the CVS tree.  Or something.  Regardless, we've taken steps to
> make sure the CVS data is safe and restorable.

Could you please stop making random accusations? Pavel probably has
better things to do than to write a 'BK virus'. And about that comment
'taking steps to make sure CVS data is safe'...

On Sat, May 10, 2003 at 07:04:55AM -0700, Larry McVoy wrote:
> Dave, I put RH 7.3 on there but didn't install any security fixes, you get
> to do that fun job if you care.

Hmm, let's see https://rhn.redhat.com/errata/rh73-errata-security.html

Remote vulnerabilities for at least, CVS, OpenSSH, OpenSSL, Sendmail,
Apache, Samba, and MySQL.

I sure hope Dave cared, because I wouldn't even consider plugging an
unpatched anything into the network in the first place. Let alone
announce this fact to a widely distributed mailing list.

Even without such a clear announcement any new machine that I connect is
typically portscanned within 30 minutes. Maybe the situation is worse at
CMU because CERT is in our address space or something, but still.

Jan

