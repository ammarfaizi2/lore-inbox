Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266905AbTGOIcr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 04:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266907AbTGOIcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 04:32:47 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:14285 "EHLO gaston")
	by vger.kernel.org with ESMTP id S266905AbTGOIcn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 04:32:43 -0400
Subject: Re: radeonfb patch for 2.4.22...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: ajoshi@kernel.crashing.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10307141342420.28472-100000@gate.crashing.org>
References: <Pine.LNX.4.10.10307141342420.28472-100000@gate.crashing.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1058258835.629.12.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 15 Jul 2003 10:47:16 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> This is not true, see the above.  Also, its hard to "accept patches" from
> people if you do NOT recieve any patches from them!  Ben's style is to get
> the maintainers of drivers to go around and search for his personal tree
> and do their own diffs from that tree, instead of him sending a patch to
> the maintainer.

Ok, please stop that, I did post patches publically and you were always
CCed, I have really no time to spend on useless arguments here, the code
is there, it works, it fixes bugs, you didn't even look at it since you
claim it's all in your 0.1.8, so please, stop bs'ing us.

I spent a significant amount of time tracking problems that users
reported after they told me they never got any useful reply from you.
Some obvious fixes like the VRAM amount fix for LY chips, which is still
broken in your 0.1.8, have been around -ac etc... for monthes. I DO NOT
care about beeing "maintainer" just to get my name in there, all I care
about right now is getting those fixes in so the driver works and
concentrate on more interesting matters.

I spent several hours redoing most of my patches against 0.1.8, which is
what Marcelo merged, I won't do it again. If you don't agree with the
version change (which was here only to avoid confusion when getting user
reports), then send Marcelo a patch that tells "0.1.9" and be done with
it.
 
Ben.

