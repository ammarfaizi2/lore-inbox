Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264888AbTF0WGd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 18:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbTF0WFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 18:05:55 -0400
Received: from pizda.ninka.net ([216.101.162.242]:19641 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264879AbTF0WFj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 18:05:39 -0400
Date: Fri, 27 Jun 2003 15:13:38 -0700 (PDT)
Message-Id: <20030627.151338.21924648.davem@redhat.com>
To: davidel@xmailserver.org
Cc: mbligh@aracnet.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: networking bugs and bugme.osdl.org
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.55.0306271509540.4457@bigblue.dev.mcafeelabs.com>
References: <Pine.LNX.4.55.0306271454490.4457@bigblue.dev.mcafeelabs.com>
	<20030627.150248.08328103.davem@redhat.com>
	<Pine.LNX.4.55.0306271509540.4457@bigblue.dev.mcafeelabs.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Davide Libenzi <davidel@xmailserver.org>
   Date: Fri, 27 Jun 2003 15:11:53 -0700 (PDT)
   
   Is a bug report more useful for the user of a "system" or for the
   "system" itself ?

You can ask the same question about a patch, and my answer
is the same, "it depends upon the bug/patch and whether
the people it affects actually care about it".

What's truly "useful" for the "system" are things that allow
the people that maintain it to SCALE.  Lossless bug and patch
databases that force me to look at each and every item do not scale.

What you don't understand is that I, and most of the people who help
me, do this because I and they want to.  So as soon as things get
introduced that make us less "want" to do this you can be sure
contributions will slump slowly but surely to nothing.
