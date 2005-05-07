Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262741AbVEGSqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262741AbVEGSqf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 14:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbVEGSqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 14:46:35 -0400
Received: from pythagoras.zen.co.uk ([212.23.3.140]:50089 "EHLO
	pythagoras.zen.co.uk") by vger.kernel.org with ESMTP
	id S262741AbVEGSqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 14:46:33 -0400
Date: Sat, 7 May 2005 19:46:10 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: Ricky Beam <jfbeam@bluetronic.net>
Cc: Stefan Smietanowski <stesmi@stesmi.com>,
       Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: /proc/cpuinfo format - arch dependent!
Message-ID: <20050507184610.GE7130@gallifrey>
References: <427D000B.40803@stesmi.com> <Pine.GSO.4.33.0505071351360.19035-100000@sweetums.bluetronic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.33.0505071351360.19035-100000@sweetums.bluetronic.net>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.6.10-5-k7-smp (i686)
X-Uptime: 19:40:17 up  7:22,  1 user,  load average: 2.09, 2.06, 2.01
User-Agent: Mutt/1.5.6+20040907i
X-Originating-Pythagoras-IP: [212.23.14.246]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ricky Beam (jfbeam@bluetronic.net) wrote:
> 
> Your HT DC CPU counts as 4 cpus total... the same as two HT processors.
> The system does not fundamentally need to make a distinction on dual core
> vs. two actual chips + heat sinks + fans.  The system will perform almost
> identically (if not acutally identically) to a dual (single core) processor
> system.

That *might* be the case for a current one; but I'm sure dual core
processors will end up sharing a level of cache/bus arbitration
sometime.  Anyway it is a bit nasty not to real dual-core'd ness
to things, after all they might get upset if someone tried to hotswap
one.....

Dave
P.S. On the side note of early dual core chips; there is an R65c00/21
and R65c29 listed in a 1985 Rockwell datasheet I've got - dual 6502s!

 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
