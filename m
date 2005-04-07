Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262628AbVDGX2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262628AbVDGX2Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 19:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbVDGX1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 19:27:34 -0400
Received: from fire.osdl.org ([65.172.181.4]:10677 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262612AbVDGXZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 19:25:52 -0400
Date: Thu, 7 Apr 2005 16:27:44 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Martin Pool <mbp@sourcefrog.net>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       David Lang <dlang@digitalinsight.com>
Subject: Re: Kernel SCM saga..
In-Reply-To: <1112852302.29544.75.camel@hope>
Message-ID: <Pine.LNX.4.58.0504071626290.28951@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> 
 <20050406193911.GA11659@stingr.stingr.net>  <pan.2005.04.07.01.40.20.998237@sourcefrog.net>
  <20050407014727.GA17970@havoc.gtf.org>  <pan.2005.04.07.02.25.56.501269@sourcefrog.net>
  <Pine.LNX.4.62.0504061931560.10158@qynat.qvtvafvgr.pbz> <1112852302.29544.75.camel@hope>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Apr 2005, Martin Pool wrote:
> 
> Importing the first snapshot (2004-01-01) took 41.77s user, 1:23.79
> total.  Each subsequent day takes about 10s user, 30s elapsed to commit
> into bzr.  The speeds are comparable to CVS or a bit faster, and may be
> faster than other distributed systems. (This on a laptop with a 5400rpm
> disk.)  Pulling out a complete copy of the tree as it was on a previous
> date takes about 14 user, 60s elapsed.

If you have an exportable tree, can you just make it pseudo-public, tell
me where to get a buildable system that works well enough, point me to
some documentation, and maybe I can get some feel for it?

		Linus
