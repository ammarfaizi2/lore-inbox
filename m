Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbWFTU6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWFTU6j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 16:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbWFTU6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 16:58:39 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:25547 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751031AbWFTU6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 16:58:39 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44986126.506@s5r6.in-berlin.de>
Date: Tue, 20 Jun 2006 22:57:10 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Linus Torvalds <torvalds@osdl.org>, Al Viro <viro@ftp.linux.org.uk>,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       Ben Collins <bcollins@ubuntu.com>,
       Jody McIntyre <scjody@modernduck.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [git pull] ieee1394 tree for 2.6.18
References: <44954102.3090901@s5r6.in-berlin.de> <Pine.LNX.4.64.0606191902350.5498@g5.osdl.org> <20060620025552.GO27946@ftp.linux.org.uk> <Pine.LNX.4.64.0606192007460.5498@g5.osdl.org> <20060620175321.GA7463@flint.arm.linux.org.uk> <44984CA1.5010308@s5r6.in-berlin.de> <20060620193422.GA10748@flint.arm.linux.org.uk>
In-Reply-To: <20060620193422.GA10748@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.884) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> The point was to try to establish when we could consider the tree from
> which we'd asked Linus to pull from as being sufficiently old that it
> would not be pulled from without another request being sent - or if it
> was pulled from, that we wouldn't get an email from Linus about the fact
> there was new stuff in there.

You could /a/ try to come to an agreement with him about a less brittle 
protocol, or /b/ think of your mail as an "announcement" rather than a 
"request" (for your peace of mind) and follow up with a repost of the 
announcement if you come to know that your updates did not appear in 
Linus' tree when the end of a merge window is near.

(Of course I cannot really assess your requirements and workload, not 
being maintainer of a large or highly connected kernel component myself. 
So ignore if I'm suggesting something stupid here.)
-- 
Stefan Richter
-=====-=-==- -==- =-=--
http://arcgraph.de/sr/
