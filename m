Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1245C48BE8
	for <io-uring@archiver.kernel.org>; Sat, 12 Jun 2021 19:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E7D2613CD
	for <io-uring@archiver.kernel.org>; Sat, 12 Jun 2021 19:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbhFLTLu (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 12 Jun 2021 15:11:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231532AbhFLTLs (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Sat, 12 Jun 2021 15:11:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id BA9C561001;
        Sat, 12 Jun 2021 19:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623524988;
        bh=+C/ydNkuGTpsBaL5aM3iX+eDuWeFW3YOYP06SZ5Wljc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=q7+8/7Q5N/FQnFed23sqZdrY63WoZKKjBNv2u/GieczJpmernyrYBuvoptJ/Tt7Mr
         kG5ArOuTWuOgRyD/QHMCsasvZ35ph8xmfAcxDq5H52S9mL3pm4PwphVKd9R0nEiaPj
         TGXynKjWMv2MKDuB+rM7wXQJizkwSNlx3TLT+64IZ0RxyifOEeh9umhCTaIPUJGC8E
         qWGNEvJvwlhkUz0nTTQzcvol0cnbXJCSf4gZPJPiuqKj2HzWdgNODbVG7N1DU6lOUi
         R+hLH19SulQ/ldWhxxs806XYIXsiTBcz0Q47WEP8u6UjdfxRlXvItJqwPJjtRvNBMj
         6unHYIeeN78iA==
Subject: Re: [GIT PULL] io_uring fixes for 5.13-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <8a4e5d77-0b4c-cbd4-6ffa-eeff83ed16af@kernel.dk>
References: <8a4e5d77-0b4c-cbd4-6ffa-eeff83ed16af@kernel.dk>
X-PR-Tracked-List-Id: <io-uring.vger.kernel.org>
X-PR-Tracked-Message-Id: <8a4e5d77-0b4c-cbd4-6ffa-eeff83ed16af@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/io_uring-5.13-2021-06-12
X-PR-Tracked-Commit-Id: 9690557e22d63f13534fd167d293ac8ed8b104f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b2568eeb961c1bb79ada9c2b90f65f625054adaf
Message-Id: <162352498873.5734.3164697279230501079.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Jun 2021 19:09:48 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        io-uring <io-uring@vger.kernel.org>
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

The pull request you sent on Sat, 12 Jun 2021 09:13:30 -0600:

> git://git.kernel.dk/linux-block.git tags/io_uring-5.13-2021-06-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b2568eeb961c1bb79ada9c2b90f65f625054adaf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
