Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263417AbTIBBI5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 21:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263419AbTIBBI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 21:08:57 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:8577
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263417AbTIBBIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 21:08:54 -0400
Date: Tue, 2 Sep 2003 03:09:03 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Xose Vazquez Perez <xose@wanadoo.es>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22pre7aa1: unresolved in sk98lin
Message-ID: <20030902010903.GA1599@dualathlon.random>
References: <3F53EC5F.5090005@wanadoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F53EC5F.5090005@wanadoo.es>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 03:03:27AM +0200, Xose Vazquez Perez wrote:
> Andrea Arcangeli wrote:
> 
> > I'm CCing the authors of the driver, is there a new version or are we the
> > first triggering it? I can fix it myself but I'd prefer to avoid any
> > duplication since it's not a one liner.
> 
> 2.4.23-prex driver is very old(v6.02 Dec-2002)
> patch-2.4.22-ac1 has more recent version but latest are at SK web site:
> http://www.syskonnect.com/syskonnect/support/driver/htm/sk98lin.htm

applied, thanks.

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
