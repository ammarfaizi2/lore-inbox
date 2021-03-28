Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD76C433E6
	for <io-uring@archiver.kernel.org>; Sun, 28 Mar 2021 19:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6BFA619A0
	for <io-uring@archiver.kernel.org>; Sun, 28 Mar 2021 19:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbhC1TLo (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 28 Mar 2021 15:11:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229950AbhC1TL1 (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Sun, 28 Mar 2021 15:11:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2613761972;
        Sun, 28 Mar 2021 19:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616958687;
        bh=4O5kC69ThOXA1jpygYwLWrjLJ6KI+fxt4AMJMh7vPbo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FFp4NyHNgOpUYbaWE9kDQ4i8NwyB4PKriZCvEYcC+VRg4hVHy3KIEHlQCO5He9O2j
         zF263D/qQl8bT0IUwOXO0VnC8cfjgTaOVu+N63yuhCSYquS4k/P3AIA/LWitvNe7p/
         rQuMWOuUl+CXptMHjQF/tEF2VdJeikN09WGSXv3IRcvkGmU81pfTEvxn/wORuyT/QI
         CSrEEgOAikBSc46WKFyX8slwbZ9uzpMzaC26xdKJN8ZxtCz5Nyb1nbHQ9DR8E+XFCI
         S4q8akwPtoWrKigSLcdflqxoglHrTCxyAILr2jpXTaC5+CU6wRDlsbISmiSC/ZEKCv
         H+s8nouHC515A==
Subject: Re: [GIT PULL] io_uring fixes for 5.12-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <aa67d57a-ba51-f443-c0f2-43d455bff25c@kernel.dk>
References: <aa67d57a-ba51-f443-c0f2-43d455bff25c@kernel.dk>
X-PR-Tracked-List-Id: <io-uring.vger.kernel.org>
X-PR-Tracked-Message-Id: <aa67d57a-ba51-f443-c0f2-43d455bff25c@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/io_uring-5.12-2021-03-27
X-PR-Tracked-Commit-Id: 2b8ed1c94182dbbd0163d0eb443a934cbf6b0d85
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b44d1ddcf835b39a8dc14276d770074deaed297c
Message-Id: <161695868713.24587.289201187635448486.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Mar 2021 19:11:27 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        io-uring <io-uring@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

The pull request you sent on Sat, 27 Mar 2021 19:01:53 -0600:

> git://git.kernel.dk/linux-block.git tags/io_uring-5.12-2021-03-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b44d1ddcf835b39a8dc14276d770074deaed297c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
