Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbVI3VYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbVI3VYg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 17:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932591AbVI3VYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 17:24:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19614 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932294AbVI3VYg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 17:24:36 -0400
Date: Fri, 30 Sep 2005 14:24:06 -0700
From: Chris Wright <chrisw@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 05/10] [PATCH]: Missing acct/mm calls in compat_do_execve()
Message-ID: <20050930212406.GH16352@shell0.pdx.osdl.net>
References: <20050930022016.640197000@localhost.localdomain> <20050930022228.946664000@localhost.localdomain> <Pine.LNX.4.61.0509300645530.7129@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0509300645530.7129@goblin.wat.veritas.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Hugh Dickins (hugh@veritas.com) wrote:
> The patch is good, but for -stable?  Spelling corrections next?

Heh, I think you've got a good point.  This one doesn't have any real
nasty side-effects that I can see.  David do you have objections to
dropping this one from -stable?

thanks,
-chris
