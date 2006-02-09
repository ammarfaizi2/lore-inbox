Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbWBINI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWBINI0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 08:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbWBINI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 08:08:26 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:31210 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S932367AbWBINI0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 08:08:26 -0500
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: git for dummies, anyone? (was: Re: How in tarnation do I git v2.6.16-rc2?  hg died and I still don't git git)
References: <20060208070301.1162e8c3.pj@sgi.com>
From: Jes Sorensen <jes@sgi.com>
Date: 09 Feb 2006 08:08:23 -0500
In-Reply-To: <20060208070301.1162e8c3.pj@sgi.com>
Message-ID: <yq0vevollx4.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Paul" == Paul Jackson <pj@sgi.com> writes:

Paul> I'm trying to git a copy of Linus's tree, checked out only up
Paul> through revision v2.6.16-rc2, so that I can lay down Andrew's
Paul> latest broken-out quilt patch set for 2.6.16-rc2-mm1 on top of
Paul> it.

Hi Paul,

I had a similar problem yesterday and was pointed at
https://wiki.ubuntu.com/KernelGitGuide?highlight=%28CategoryKernel%29
as a starting point.

I was thinking it would be really nice if someone fancied writing a
git guide for dummies (like me) who only use git on and off. Something
that could be put either on git.kernel.org or a similar place.

Things like how to do basic checkouts, how to revert back to a certain
snapshot or a certain commit id, how to use git-bisect to track
breakage and other basic stuff.

Anyone looking for a pet project who fancies writing up something like
this? I can say for sure that it will be appreciated.

Cheers,
Jes
