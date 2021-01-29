Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6CDC433DB
	for <io-uring@archiver.kernel.org>; Fri, 29 Jan 2021 22:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78D0264DE9
	for <io-uring@archiver.kernel.org>; Fri, 29 Jan 2021 22:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbhA2WNS (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 29 Jan 2021 17:13:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:57240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233545AbhA2WM7 (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Fri, 29 Jan 2021 17:12:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 10DA164DF1;
        Fri, 29 Jan 2021 22:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611958339;
        bh=nEOc671lFxHrdO/urEnYSOIJ2QU4oSkl5D9ZiKEKrrM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lhBDnaGZxaZPxW2qNMRPpIlC5KTbSVHQn1HyaOy0xx0XSba6dOmAcI+jDVoKI88oI
         PmQvSYf86rGlRco9u4Sa5dFG+y5BSvlZEydqNR/Jae4B8aHO2Kw8v20j5X3C0wfwHU
         /Dp7Exy69VLWFpA8BVL2xHeDa+ecaLt2Q/utKg8qC6xp86b/MHVlzVtyzlZ/2nvmwR
         vPmHPh1pdhsX0J+HWWxmz14HmPGNoyP5cb66eZwhYOM4oNdMJHxLbFbyQr8s4xN/S3
         IN8QOc19l1cwHkaeZ6mFYWAs5OBBkM85VgI2hT5ojmAmpVuRav3ZobOFUs8FbCALr+
         Q8/Ge8T/OWhvg==
Subject: Re: [GIT PULL] io_uring fixes for 5.11-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <f708dbad-9147-8a9e-2a9a-c0037a99eb60@kernel.dk>
References: <f708dbad-9147-8a9e-2a9a-c0037a99eb60@kernel.dk>
X-PR-Tracked-List-Id: <io-uring.vger.kernel.org>
X-PR-Tracked-Message-Id: <f708dbad-9147-8a9e-2a9a-c0037a99eb60@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/io_uring-5.11-2021-01-29
X-PR-Tracked-Commit-Id: 3a7efd1ad269ccaf9c1423364d97c9661ba6dafa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c0ec4ffc40939e9a5a5844ce455f2b5b66a005fd
Message-Id: <161195833910.1476.10538227342349466968.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Jan 2021 22:12:19 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        io-uring <io-uring@vger.kernel.org>
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

The pull request you sent on Fri, 29 Jan 2021 12:10:19 -0700:

> git://git.kernel.dk/linux-block.git tags/io_uring-5.11-2021-01-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c0ec4ffc40939e9a5a5844ce455f2b5b66a005fd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
