Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271674AbRICKqf>; Mon, 3 Sep 2001 06:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271676AbRICKq0>; Mon, 3 Sep 2001 06:46:26 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56848 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271674AbRICKqH>; Mon, 3 Sep 2001 06:46:07 -0400
Subject: Re: when will reiserfs for big-endian machines be added to the kernel?
To: reiser@namesys.com (Hans Reiser)
Date: Mon, 3 Sep 2001 11:49:58 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), thunder7@xs4all.nl,
        linux-kernel@vger.kernel.org, jeffm@suse.com (Jeff Mahoney),
        reiserfs-dev@namesys.com
In-Reply-To: <3B9359E9.5D4074E@namesys.com> from "Hans Reiser" at Sep 03, 2001 02:22:33 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15drIl-0001Tv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Any comments by users on whether they are stable?  They have been in Alan's tree
> for some time, and there have been no complaints that I recall, is anybody using
> them?

I've had no complaints, and a small patch for parisc (queued) which also
wanted the alignment stuff.

> Maybe they should go into the next batch of patches for Linus if they are
> stable.

I think its a candidate
