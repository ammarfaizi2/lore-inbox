Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130560AbQLKA3I>; Sun, 10 Dec 2000 19:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131192AbQLKA26>; Sun, 10 Dec 2000 19:28:58 -0500
Received: from jalon.able.es ([212.97.163.2]:5539 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S130560AbQLKA2z>;
	Sun, 10 Dec 2000 19:28:55 -0500
Date: Mon, 11 Dec 2000 00:58:21 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: "David D . W . Downey" <pgpkeys@hislinuxbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: No shared memory??
Message-ID: <20001211005821.A2556@werewolf.able.es>
Reply-To: jamagallon@able.es
In-Reply-To: <Pine.LNX.4.30.0012100306530.4353-100000@playtoy.hislinuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.30.0012100306530.4353-100000@playtoy.hislinuxbox.com>; from pgpkeys@hislinuxbox.com on Sun, Dec 10, 2000 at 12:11:14 +0100
X-Mailer: Balsa 1.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 10 Dec 2000 12:11:14 David D.W. Downey wrote:
> 
> OK, got a tiny little bug here.
> 
> When running top, procinfo, or free I get 0 for Shared memory. Obviously
> this is incorrect. What has changed from the 2.2.x and the 2.4.x that
> would cause these apps to misreport this information.
> 

Have you mounted /dev/shm (shared memory) filesystem ?
Take a look at kernel documentation under linux/Documentation/Changes.

-- 
Juan Antonio Magallon Lacarta                                 #> cd /pub
mailto:jamagallon@able.es                                     #> more beer

Linux werewolf 2.2.18-pre25-vm #4 SMP Fri Dec 8 01:59:48 CET 2000 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
