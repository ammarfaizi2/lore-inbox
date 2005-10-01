Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbVJACSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbVJACSl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 22:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbVJACSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 22:18:41 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:15838
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750714AbVJACSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 22:18:41 -0400
Date: Fri, 30 Sep 2005 19:18:36 -0700 (PDT)
Message-Id: <20050930.191836.56628745.davem@davemloft.net>
To: chrisw@osdl.org
Cc: hugh@veritas.com, linux-kernel@vger.kernel.org, stable@kernel.org,
       jmforbes@linuxtx.org, zwane@arm.linux.org.uk, tytso@mit.edu,
       rdunlap@xenotime.net, chuckw@quantumlinux.com, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH 05/10] [PATCH]: Missing acct/mm calls in
 compat_do_execve()
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050930212406.GH16352@shell0.pdx.osdl.net>
References: <20050930022228.946664000@localhost.localdomain>
	<Pine.LNX.4.61.0509300645530.7129@goblin.wat.veritas.com>
	<20050930212406.GH16352@shell0.pdx.osdl.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Wright <chrisw@osdl.org>
Date: Fri, 30 Sep 2005 14:24:06 -0700

> * Hugh Dickins (hugh@veritas.com) wrote:
> > The patch is good, but for -stable?  Spelling corrections next?
> 
> Heh, I think you've got a good point.  This one doesn't have any real
> nasty side-effects that I can see.  David do you have objections to
> dropping this one from -stable?

No objections, you can drop it.
