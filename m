Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbWIBSyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWIBSyi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 14:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWIBSyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 14:54:38 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:46288 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751277AbWIBSyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 14:54:37 -0400
Date: Sat, 2 Sep 2006 20:47:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Steven Whitehouse <swhiteho@redhat.com>, linux-kernel@vger.kernel.org,
       Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, hch@infradead.org
Subject: Re: [PATCH 03/16] GFS2: bmap and inode functions
Message-ID: <20060902184721.GA7312@elte.hu>
References: <1157031054.3384.788.camel@quoit.chygwyn.com> <Pine.LNX.4.61.0609011355410.15283@yvahk01.tjqt.qr> <20060902060939.GB16484@elte.hu> <Pine.LNX.4.61.0609020914570.24701@yvahk01.tjqt.qr> <20060902162345.GA23695@elte.hu> <20060902162547.GA23962@elte.hu> <Pine.LNX.4.61.0609022025360.14813@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0609022025360.14813@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4984]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

> 
> >btw., it is in CodingStyle too:
> 
> It may be used in a lot of places, but there is no explicit written 
> rule. That's why there actually *IS* "if(" in the kernel too.

Not all obvious things are written into it, it's not a legal document. 
Currently only 1.2% of the toplevel */*.c files have the 'if(' 
construct. It's just a small style bug (it's not a big issue at all), i 
was only nitpicking. Lets move over to more important issues, ok? :-)

	Ingo

-- 
VGER BF report: H 0
