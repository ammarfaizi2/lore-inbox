Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268578AbTBYV6C>; Tue, 25 Feb 2003 16:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268579AbTBYV6C>; Tue, 25 Feb 2003 16:58:02 -0500
Received: from bitmover.com ([192.132.92.2]:57528 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S268578AbTBYV6C>;
	Tue, 25 Feb 2003 16:58:02 -0500
Date: Tue, 25 Feb 2003 14:08:11 -0800
From: Larry McVoy <lm@bitmover.com>
To: William Lee Irwin III <wli@holomorphy.com>, Chris Wedgwood <cw@f00f.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030225220811.GA9317@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	Chris Wedgwood <cw@f00f.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Larry McVoy <lm@bitmover.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030222231552.GA31268@work.bitmover.com> <3610000.1045957443@[10.10.2.4]> <20030224045616.GB4215@work.bitmover.com> <48940000.1046063797@[10.10.2.4]> <20030224065826.GA5665@work.bitmover.com> <1046093309.1246.6.camel@irongate.swansea.linux.org.uk> <20030225051956.GA18302@f00f.org> <20030225052602.GW10411@holomorphy.com> <20030225212115.GB21870@f00f.org> <20030225212134.GD10411@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030225212134.GD10411@holomorphy.com>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 01:21:34PM -0800, William Lee Irwin III wrote:
> On Mon, Feb 24, 2003 at 09:26:02PM -0800, William Lee Irwin III wrote:
> >> Could you help identify the regressions? Profiles? Workload?
> 
> On Tue, Feb 25, 2003 at 01:21:15PM -0800, Chris Wedgwood wrote:
> > I the OSDL data that Cliff White pointed out sufficient to work-with,
> > or do you want specific tests run with oprofile outputs?
> 
> oprofile is what's needed. Looks like he's taking care of that too.

Without doing something about the page coloring problem (and he might be)
the numbers will be fairly meaningless.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
