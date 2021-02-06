Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B24C433E0
	for <io-uring@archiver.kernel.org>; Sat,  6 Feb 2021 22:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0452664E2A
	for <io-uring@archiver.kernel.org>; Sat,  6 Feb 2021 22:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbhBFWqo (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 6 Feb 2021 17:46:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:47618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhBFWqo (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Sat, 6 Feb 2021 17:46:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 4023A64E2A;
        Sat,  6 Feb 2021 22:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612651564;
        bh=HuW2Yyao9ukaqW21+AmY9+W71Ut72eDwGnX+xExGbw4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fH5asAitdUY+1idpYrJ0t2FSlyUOrWRqGx5c5KmHvE9Z2/J7RbPvoNU3Cl2lAUROx
         hvm7VTFtQHK0TXcu+WRU3ZjpxfrtFRcPBi82FbvBOgnGwRolPZDgHOD2uRr3V/8mye
         2mIAZv2DuH5ZDc5CKfty0gAWEG6JYSNAtgCubofc6F4IHOPigMS1MzGa+JGJWq6F59
         6pygVstGY1e1j7GmdlyxvZpGEnwm2bqDu6H84B00PPmSQTvLcHWxrpWSQbxOxX6w0i
         ZJicNItvvkpIyKacg+6RRrKTGB+HrOMd8b5QD+75P4BbfNyMfWn73XDISjsVQ7s4Kx
         UpMo5xcC+cgiA==
Subject: Re: [GIT PULL] io_uring fixes for 5.11-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9f56e349-4207-4668-05aa-9cabe9caa37d@kernel.dk>
References: <9f56e349-4207-4668-05aa-9cabe9caa37d@kernel.dk>
X-PR-Tracked-List-Id: <io-uring.vger.kernel.org>
X-PR-Tracked-Message-Id: <9f56e349-4207-4668-05aa-9cabe9caa37d@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/io_uring-5.11-2021-02-05
X-PR-Tracked-Commit-Id: aec18a57edad562d620f7d19016de1fc0cc2208c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 860b45dae969966a52b4dd0470d8fca8479e4e4b
Message-Id: <161265156412.9050.8813717363361355623.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Feb 2021 22:46:04 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        io-uring <io-uring@vger.kernel.org>
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

The pull request you sent on Fri, 5 Feb 2021 16:16:45 -0700:

> git://git.kernel.dk/linux-block.git tags/io_uring-5.11-2021-02-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/860b45dae969966a52b4dd0470d8fca8479e4e4b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
