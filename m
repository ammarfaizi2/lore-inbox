Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264871AbTLESNj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 13:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264877AbTLESNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 13:13:39 -0500
Received: from mxsf18.cluster1.charter.net ([209.225.28.218]:48146 "EHLO
	mxsf18.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S264871AbTLESN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 13:13:26 -0500
Date: Fri, 5 Dec 2003 13:11:11 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Catching NForce2 lockup with NMI watchdog
Message-ID: <20031205181111.GA9982@forming>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031205045404.GA307@tesore.local> <16336.13962.285442.228795@alkaid.it.uu.se> <20031205083349.GA15152@forming> <16336.30392.344028.347132@alkaid.it.uu.se> <1070633973.4100.23.camel@athlonxp.bradney.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1070633973.4100.23.camel@athlonxp.bradney.info>
X-Editor: GNU Emacs 21.1
X-Operating-System: Debian GNU/Linux 2.6.0-test11-Jm i686
X-Uptime: 13:06:23 up 1 day, 21:32,  5 users,  load average: 1.00, 1.00, 1.00
User-Agent: Mutt/1.5.4i
From: Josh McKinney <forming@charter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please don't CC me, I am on the list, thanks.

On approximately Fri, Dec 05, 2003 at 03:19:33PM +0100, Craig Bradney wrote:
> I'm getting those in dmesg too...
> 
> ..MP-BIOS bug: 8254 timer not connected to IO-APIC
> ...trying to set up timer (IRQ0) through the 8259A ...  failed.
> ...trying to set up timer as Virtual Wire IRQ... failed.
> ...trying to set up timer as ExtINT IRQ... works.
> 
> 
> Do you really think this could be the problem?
> 
> If so, any ideas why I am relatively lucky to not have the crashes
> people are having? 5.5 days, then 5 hours, and now Im up to 17 hours...
> with a decent amount of use combined with idle time.
> 
> Craig
> 

At least two of us are lucky.  I can't reproduce the crashes "anymore"
either.  I am up to 2 days now, was up to 3 or 4 before I booted
2.4.23 for a while to see if I could make that kernel crash, which I
couldn't.  I will see how long I can go, since 5 days or so seems to
be the top uptime. 

-- 
Josh McKinney		     |	Webmaster: http://joshandangie.org
--------------------------------------------------------------------------
                             | They that can give up essential liberty
Linux, the choice       -o)  | to obtain a little temporary safety deserve 
of the GNU generation    /\  | neither liberty or safety. 
                        _\_v |                          -Benjamin Franklin
