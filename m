Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269068AbUJQHMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269068AbUJQHMp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 03:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269070AbUJQHMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 03:12:45 -0400
Received: from mail3.bluewin.ch ([195.186.1.75]:47560 "EHLO mail3.bluewin.ch")
	by vger.kernel.org with ESMTP id S269068AbUJQHMo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 03:12:44 -0400
Date: Sun, 17 Oct 2004 09:12:31 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gcc 3.4 "makes pointer from integer without a cast" warnings in via-rhine-c
Message-ID: <20041017071231.GA10222@k3.hellgate.ch>
Mail-Followup-To: Lee Revell <rlrevell@joe-job.com>,
	linux-kernel@vger.kernel.org
References: <1097957149.2148.22.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097957149.2148.22.camel@krustophenia.net>
X-Operating-System: Linux 2.6.9-rc2-bk1-nproc on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Oct 2004 16:05:50 -0400, Lee Revell wrote:
> I get these warnings compiling via-rhine with gcc 3.4.  What is the
> correct way to fix this?  This came up in another thread and someone
> mentioned that just adding a cast is not a "real fix" but just hides the
> problem.

I am offline most of this month, so I may have missed something important
here, but my procmail filter caught Al Viro hacking via-rhine. You may
want to have a look at the 2.6.9-rc4-bird1 patchset he announced, it
looks related (I won't be able to for another couple of weeks at least).

Roger
