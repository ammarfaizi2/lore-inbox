Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWFTTap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWFTTap (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 15:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWFTTap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 15:30:45 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:4550 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750789AbWFTTao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 15:30:44 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44984CA1.5010308@s5r6.in-berlin.de>
Date: Tue, 20 Jun 2006 21:29:37 +0200
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
References: <44954102.3090901@s5r6.in-berlin.de> <Pine.LNX.4.64.0606191902350.5498@g5.osdl.org> <20060620025552.GO27946@ftp.linux.org.uk> <Pine.LNX.4.64.0606192007460.5498@g5.osdl.org> <20060620175321.GA7463@flint.arm.linux.org.uk>
In-Reply-To: <20060620175321.GA7463@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-0.361) AWL,BAYES_05
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Mon, Jun 19, 2006 at 08:14:45PM -0700, Linus Torvalds wrote:
>>I want them to tell me what they are sending, so that _when_ I pull, I can 
>>line up the result of that pull with the mail they sent, and I can tell 
>>"ok, that's actually what the other side intended".
> 
> Given that you've complained about me sending daily pull requests
> already, how do you intend folk to handle the situation where they've
> sent you a pull request, it's apparantly been ignored, and they update
> the tree from which you pull (maybe for akpm's benefit) and then you
> eventually get around to pulling it a couple of days later?
[...]

I don't maintain git repos myself, but I'd say _branches_ or something 
like that might be the way to go.
-- 
Stefan Richter
-=====-=-==- -==- =-=--
http://arcgraph.de/sr/
