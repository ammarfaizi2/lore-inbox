Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbWI3MEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWI3MEB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 08:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbWI3MEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 08:04:01 -0400
Received: (root@vger.kernel.org) by vger.kernel.org id S1750901AbWI3MEA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 08:04:00 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:11456 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750813AbWI2WUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 18:20:55 -0400
Message-ID: <451D9C40.6070008@garzik.org>
Date: Fri, 29 Sep 2006 18:20:48 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: tridge@samba.org
CC: davids@webmaster.com, James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
References: <James.Bottomley@SteelEye.com>	<1159512998.3880.50.camel@mulgrave.il.steeleye.com>	<200609291454.k8TEsVJZ022006@laptop13.inf.utfsm.cl> <17693.37937.928098.495836@samba.org>
In-Reply-To: <17693.37937.928098.495836@samba.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tridge@samba.org wrote:
> So when I saw Linus advocating forking programs that are currently "v2
> or later" and making them "v2 only", then I asked that he clarify to
> ensure that the major contributors to the project be consulted before
> doing that. Whether it is legal is beside the point - it is good
> manners to follow the ground rules of the people who write the code.
> 
> Thankfully Linus has clarified that now in a later posting. I was
> already pretty sure he always intended for the major contributors to
> be consulted before a fork was done, but I'm glad its on the record so
> people don't start forking madly while flying a "Linus said its OK"
> banner :)


It's good manners, but ultimately users vote with their feet.

If codebase A requires that modifications be given back (GPL v2), and 
codebase A' additionally requires embedded device makers to permit users 
to use modified code in all cases, which do you think device makers -- 
and ultimately users -- will choose?

For a lot of kernel devs who voted, I got the sense that the DRM clause 
was the big stopping point.  I actually think the patent clauses might 
help things a bit, providing the "convey" language is cleared up.  But 
the DRM clause is far from technology-neutral, and doesn't take into 
account useful DRM.

DRM is just a technology.  It's not good or evil.  It's a bit like 
bittorrent:  arguably, the majority of BT usage is for copyright 
violations, but there are good uses for it too.

Further, the GPL v3 gets _too specific_ when it comes to talking about 
technological remedies.  It gets into the same trouble that politicians 
get into, when they write technological remedies into law.  Technology 
changes too rapidly to get specific.  Pretty soon you'll find that a 
useful scenario was outlawed.

	Jeff
