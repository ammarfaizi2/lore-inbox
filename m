Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267140AbRHMUTt>; Mon, 13 Aug 2001 16:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267651AbRHMUTj>; Mon, 13 Aug 2001 16:19:39 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:50697 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267140AbRHMUTg>; Mon, 13 Aug 2001 16:19:36 -0400
Subject: Re: IDE UDMA/ATA Suckage, or something else?
To: pgallen@randomlogic.com (Paul G. Allen)
Date: Mon, 13 Aug 2001 21:22:06 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux kernel developer's mailing list),
        kplug-list@kernel-panic.org (kplug-list@kernel-panic.org)
In-Reply-To: <no.id> from "Paul G. Allen" at Aug 13, 2001 11:52:36 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15WODu-00089l-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > You must disable IDE prefetch on the current versions of the AMD MP
> > chipset, you may also need to enable "noapic".
> 
> Unless I can do it with the kernel, I have no choice. The BIOS has no
> prefetch setting (which, BTW, I had disabled on all my A7V133 boards).
> So what about problems with non MP boards?

Well its entirely possible that the BIOS vendor did the right thing and
made sure you couldnt turn it on. How does your box behave with noapic ?
