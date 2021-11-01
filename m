Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF833C433EF
	for <io-uring@archiver.kernel.org>; Mon,  1 Nov 2021 17:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C898560E8C
	for <io-uring@archiver.kernel.org>; Mon,  1 Nov 2021 17:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhKARbW (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 1 Nov 2021 13:31:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229560AbhKARbU (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Mon, 1 Nov 2021 13:31:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id DF34860E78;
        Mon,  1 Nov 2021 17:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635787726;
        bh=pVof0HzCep5+CQiJQzvMz44jEHo4mfzl/f7AdZxSepw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FaCD8k0eWBiL6HoF7PgEM2IGSAPcKdP2/AXliK9iSs7NiVFH+VNKAQe+11pKGZ1gh
         mv/7VxUPIpakjxwFbdlTO/thrsHyXfJvY4MYWdak/GA79yLGR8z/QT/RIIYqyYbPGc
         fcLKvP6SV6ifKSfnqCdz6VRmTOLtXr235dN8ez9tof4VRW22Ouz19ry4gzqr1cF9Id
         jmbOfFRw8J0KYibfpbP5JpoPQnu0iMSrV7JWvZjhqfimIaSJPDxFr9zB5sTdE1Wi9G
         ur/ka1C56UDkQWMVPVj+xJ2WdhA2a4deuvGs6RMQ0JDmUKJdr5WI6TJ2fXGCHDb8Ms
         tMohhNZrkTNWA==
Subject: Re: [GIT PULL] io_uring updates for 5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <c5054513-d496-e15e-91ef-dcdbf9dda2c4@kernel.dk>
References: <c5054513-d496-e15e-91ef-dcdbf9dda2c4@kernel.dk>
X-PR-Tracked-List-Id: <io-uring.vger.kernel.org>
X-PR-Tracked-Message-Id: <c5054513-d496-e15e-91ef-dcdbf9dda2c4@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.16/io_uring-2021-10-29
X-PR-Tracked-Commit-Id: 1d5f5ea7cb7d15b9fb1cc82673ebb054f02cd7d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8d1f01775f8ead7ee313403158be95bffdbb3638
Message-Id: <163578772677.18307.3805983237653741705.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Nov 2021 17:28:46 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        io-uring <io-uring@vger.kernel.org>
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

The pull request you sent on Sun, 31 Oct 2021 13:41:47 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.16/io_uring-2021-10-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8d1f01775f8ead7ee313403158be95bffdbb3638

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
