Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265414AbSLMWDE>; Fri, 13 Dec 2002 17:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265423AbSLMWDE>; Fri, 13 Dec 2002 17:03:04 -0500
Received: from host145.south.iit.edu ([216.47.130.145]:61824 "EHLO
	lostlogicx.com") by vger.kernel.org with ESMTP id <S265414AbSLMWDD>;
	Fri, 13 Dec 2002 17:03:03 -0500
Date: Fri, 13 Dec 2002 16:10:49 -0600
From: Brandon Low <lostlogic@gentoo.org>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: procps 2.x vs. procps 3.x
Message-ID: <20021213161049.D407@lostlogicx.com>
References: <200212131514.gBDFEhL268190@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200212131514.gBDFEhL268190@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Fri, Dec 13, 2002 at 10:14:43AM -0500
X-Operating-System: Linux found 2.4.20-pre10-mjc1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If nobody else knows about it, it's not too likely to get fixed.
> Send bug reports to procps-feedback@lists.sf.net please.
> 
Sorry about that, sent bug report and link to our bug track on it.

> Before you do: "certain characters" will need some explaining.
> (position? value? completely gone or turned into a space?)

In the bug report.
> 
> > but the 3.x series is much prettier and
> > feature rich than the 2.x series.  On the other hand, 2.x is 
> > consistently more up to date with kernel changes since RML and Riel
> > maintain it and are intimately familiar with current kernel
> > development.  
> 
> I just got the last bit, /proc/*/wchan usage on 2.5.xx kernels.
> Oddly, I'm ahead right now. I have a vmstat that uses a fast O(1)
> algorithm on 2.5.xx kernels and reports the IO-wait time. I also
> have a sysctl that handles the 2.5.xx VLAN interfaces.

Amazing work, thanks!  I hope to get your procps into Gentoo Stable RSN :)

--Brandon
