Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0EFC433FE
	for <io-uring@archiver.kernel.org>; Fri, 17 Sep 2021 16:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B247761019
	for <io-uring@archiver.kernel.org>; Fri, 17 Sep 2021 16:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244154AbhIQQbJ (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 17 Sep 2021 12:31:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244135AbhIQQbH (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Fri, 17 Sep 2021 12:31:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id AAE2D61019;
        Fri, 17 Sep 2021 16:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631896185;
        bh=xj+5JY3TPkof0038GE5PcyPNt7UPUAFr8KMuzpBQ6EU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=J5X0R0nCfE4pk/gcOvbklSOmruL72p5srQ/ZSNf/ZoWdGFGs8pf2RtFEuTT7um0P2
         bgDR9x328yr23BhzW5K1buvbPSKLNxlH4/dItqTvur8s2FCmAq1keiFo+WAmPNA+d6
         OLkzrDswZKvLTYDC7SEYRMrTmUKiI6WPpX4Mczes439zTwOxyN+3lzR6NSWzmvEETT
         xnt1PvlM7kxqnBd1PSNJqiV4cmX8871r35oEEl+xScY4ZkkAubfKSP/NHewvxDFUl7
         IPmCGYMyGQukh+wn5/NcbEFdF6/2KSGZj/sjWZs643rzW402onTh79iqJs/484yMvF
         byur9KLQm/9fg==
Subject: Re: [GIT PULL] io_uring fixes for 5.15-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <a80f867d-ae3f-02d4-405d-2e9e0fa56439@kernel.dk>
References: <a80f867d-ae3f-02d4-405d-2e9e0fa56439@kernel.dk>
X-PR-Tracked-List-Id: <io-uring.vger.kernel.org>
X-PR-Tracked-Message-Id: <a80f867d-ae3f-02d4-405d-2e9e0fa56439@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/io_uring-5.15-2021-09-17
X-PR-Tracked-Commit-Id: 5d329e1286b0a040264e239b80257c937f6e685f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0bc7eb03cbd3e5d057cbe2ee15ddedf168f25a8d
Message-Id: <163189618567.30150.18148180525729332030.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Sep 2021 16:29:45 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        io-uring <io-uring@vger.kernel.org>
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

The pull request you sent on Fri, 17 Sep 2021 08:44:28 -0600:

> git://git.kernel.dk/linux-block.git tags/io_uring-5.15-2021-09-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0bc7eb03cbd3e5d057cbe2ee15ddedf168f25a8d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
