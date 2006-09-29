Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422832AbWI2VsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422832AbWI2VsL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 17:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422839AbWI2VsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 17:48:10 -0400
Received: from dp.samba.org ([66.70.73.150]:195 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S1422832AbWI2VsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 17:48:08 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17693.37937.928098.495836@samba.org>
Date: Sat, 30 Sep 2006 07:46:25 +1000
To: davids@webmaster.com
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement 
In-Reply-To: <200609291454.k8TEsVJZ022006@laptop13.inf.utfsm.cl>
References: <James.Bottomley@SteelEye.com>
	<1159512998.3880.50.camel@mulgrave.il.steeleye.com>
	<200609291454.k8TEsVJZ022006@laptop13.inf.utfsm.cl>
X-Mailer: VM 7.19 under Emacs 21.4.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

> That really is totally against the spirit of the GPL and, frankly, I think
> it's the opposite of the attitude the free software community should be
> taking.

Not at all. Both tha free software communities and the open source
communities have been taking this attitude for a very long time.

When you release a patch to a LGPL program, what license do you choose
for the patch? You could legally choose the GPL. You could post your
GPL patch to the mailing list of the project and refuse to license it
under the LGPL. That would be legal, but very annoying.

Similarly for BSD licensed programs. When you patch those it is the
norm to contribute patches under a BSD license.

In both cases you are choosing the license the authors/maintainers of
the program chose, and that helps in reducing the impact of the
license proliferation we have at the moment. You are also doing the
morally right thing by playing by the rules of the community you are
participating in. You are acknowledging the "authors rights" to set
the ground rules for the community they are running.

I would defend the legal right of Linus or anyone else to do things
that the GPLv2 legally allows on my GPLv2 code. That doesn't mean I
have to like it, and it certainly doesn't mean I can't complain if I
thought what was being done was unreasonable.

So when I saw Linus advocating forking programs that are currently "v2
or later" and making them "v2 only", then I asked that he clarify to
ensure that the major contributors to the project be consulted before
doing that. Whether it is legal is beside the point - it is good
manners to follow the ground rules of the people who write the code.

Thankfully Linus has clarified that now in a later posting. I was
already pretty sure he always intended for the major contributors to
be consulted before a fork was done, but I'm glad its on the record so
people don't start forking madly while flying a "Linus said its OK"
banner :)

Cheers, Tridge
