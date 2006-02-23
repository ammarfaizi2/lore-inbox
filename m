Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751766AbWBWSFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbWBWSFb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 13:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751694AbWBWSFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 13:05:31 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:13033 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751763AbWBWSFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 13:05:30 -0500
Subject: Re: 2.6.16-rc4: known regressions
From: Arjan van de Ven <arjan@infradead.org>
To: Greg KH <gregkh@suse.de>
Cc: Martin Bligh <mbligh@mbligh.org>, Gabor Gombas <gombasg@sztaki.hu>,
       "Theodore Ts'o" <tytso@mit.edu>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Kay Sievers <kay.sievers@suse.de>,
       penberg@cs.helsinki.fi, bunk@stusta.de, rml@novell.com,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com
In-Reply-To: <20060223175242.GA32750@suse.de>
References: <Pine.LNX.4.64.0602211700580.30245@g5.osdl.org>
	 <20060222112158.GB26268@thunk.org>
	 <20060222154820.GJ16648@ca-server1.us.oracle.com>
	 <20060222162533.GA30316@thunk.org>
	 <20060222173354.GJ14447@boogie.lpds.sztaki.hu>
	 <20060222185923.GL16648@ca-server1.us.oracle.com>
	 <20060222191832.GA14638@suse.de>
	 <1140636588.2979.66.camel@laptopd505.fenrus.org>
	 <20060222194024.GA15703@suse.de> <43FDF10E.3030001@mbligh.org>
	 <20060223175242.GA32750@suse.de>
Content-Type: text/plain
Date: Thu, 23 Feb 2006 19:04:41 +0100
Message-Id: <1140717881.4672.82.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> They are very reluctant to upgrade kernels today, for released versions
> of the distro, and so they backport kernel fixes and security updates to
> that older kernel, just like all of the packages in a distro.  That's
> they way they work.


fedora actually regularly updates to newer kernels, as service to their
users. (And since kernels still fix more bugs than they create it's a
net win ;)

