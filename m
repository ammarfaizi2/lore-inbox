Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132492AbRDAO7R>; Sun, 1 Apr 2001 10:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132514AbRDAO7G>; Sun, 1 Apr 2001 10:59:06 -0400
Received: from ns1.cfcc.cc.fl.us ([150.176.253.67]:57480 "EHLO
	ns1.cfcc.cc.fl.us") by vger.kernel.org with ESMTP
	id <S132492AbRDAO6z>; Sun, 1 Apr 2001 10:58:55 -0400
Date: Sun, 1 Apr 2001 10:54:12 -0400
From: Mike Bennett <mbennett@ns1.cfcc.cc.fl.us>
To: linux-kernel@vger.kernel.org
Subject: aic7xxx 6.1.8 for 2.2.19
Message-ID: <20010401105412.G21419@cfcc.cc.fl.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Was getting ready to compile 2.2.19 this AM and went to
Justin's site to grab the latest aic7xxx driver.

Unfortunately, he doesn't have a patch for 2.2.19 and the
2.2.18 patch doesn't apply cleanly because the stock driver
changed.

It's a long story, but the short version is that the stock
driver has always given me timeouts with heavy disk activity.
Right now I'm using 6.0.8beta in 2.2.18 since Jan 12 and have
not had a single timeout problem. Needless to say, I won't be
upgrading kernels today.  Damn, now I've got no excuse for
not mowing the lawn... :)

Has anyone made a patch against 2.2.19 ?

