Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbTIBCHm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 22:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263426AbTIBCHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 22:07:41 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:31875
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263424AbTIBCHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 22:07:38 -0400
Date: Tue, 2 Sep 2003 04:07:48 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Xose Vazquez Perez <xose@wanadoo.es>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22pre7aa1: unresolved in sk98lin
Message-ID: <20030902020748.GC1599@dualathlon.random>
References: <3F53EC5F.5090005@wanadoo.es> <20030902010903.GA1599@dualathlon.random> <3F53F5BC.1030404@wanadoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F53F5BC.1030404@wanadoo.es>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 03:43:24AM +0200, Xose Vazquez Perez wrote:
> Andrea Arcangeli wrote:
> 
> > On Tue, Sep 02, 2003 at 03:03:27AM +0200, Xose Vazquez Perez wrote:
> 
> >>2.4.23-prex driver is very old(v6.02 Dec-2002)
> >>patch-2.4.22-ac1 has more recent version but latest are at SK web site:
> >>http://www.syskonnect.com/syskonnect/support/driver/htm/sk98lin.htm
> > 
> > 
> > applied, thanks.
> > 
> > Andrea
> 
> be careful, SK has made a stupid patch for net/configure.in.
> And it has several NICs selections but the driver is same for all of them.

I noticed it during configure, it looked only a cosmetical problem
though, and this drivers compiled and linked fine so I leave it applied
for now ;)

Andrea

/*
 * If you refuse to depend on closed software for a critical
 * part of your business, these links may be useful:
 *
 * rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.5/
 * rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.4/
 * http://www.cobite.com/cvsps/
 *
 * svn://svn.kernel.org/linux-2.6/trunk
 * svn://svn.kernel.org/linux-2.4/trunk
 */
