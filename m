Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274813AbRJ2NUA>; Mon, 29 Oct 2001 08:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274951AbRJ2NTl>; Mon, 29 Oct 2001 08:19:41 -0500
Received: from ns.caldera.de ([212.34.180.1]:1260 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S274813AbRJ2NTU>;
	Mon, 29 Oct 2001 08:19:20 -0500
Date: Mon, 29 Oct 2001 14:19:42 +0100
Message-Id: <200110291319.f9TDJgx31343@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: manik@cisco.com (Manik Raina)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] small fix for warning in exec_domain.c
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <Pine.GSO.4.33.0110291428230.20450-100000@cbin2-view1.cisco.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.GSO.4.33.0110291428230.20450-100000@cbin2-view1.cisco.com> you wrote:
> Hi all,

> When support for Kernel modules is not configured, we get
> a warning. This fix solves that.

Looks sane to me.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
