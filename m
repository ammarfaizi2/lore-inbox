Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132827AbQKXLmo>; Fri, 24 Nov 2000 06:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132831AbQKXLme>; Fri, 24 Nov 2000 06:42:34 -0500
Received: from [194.213.32.137] ([194.213.32.137]:2820 "EHLO bug.ucw.cz")
        by vger.kernel.org with ESMTP id <S132830AbQKXLmW>;
        Fri, 24 Nov 2000 06:42:22 -0500
Message-ID: <20001124111539.A879@bug.ucw.cz>
Date: Fri, 24 Nov 2000 11:15:39 +0100
From: Pavel Machek <pavel@suse.cz>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org, Frank Ronny Larsen <frankrl@nhn.no>,
        Frank Ronny Larsen <gobo@gimle.nu>, Jannik Rasmussen <jannik@east.no>,
        Lars Christian Nygård <lars@snart.com>
Subject: Re: ext2 compression: How about using the Netware principle?
In-Reply-To: <3A193A12.9B384B61@karlsbakk.net> <20001122132922.A41@toy> <3A1D12B5.D0AF250C@karlsbakk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3A1D12B5.D0AF250C@karlsbakk.net>; from Roy Sigurd Karlsbakk on Thu, Nov 23, 2000 at 01:51:01PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Besides: you can do this in userspace with existing e2compr. Should take
> > less than 2 days to implement.
> 
> ok
> never seen that...

e2compr is suite of patches to do online compression. It is pretty
mature. You should take a look; turning online compression into
offline is pretty trivial.

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
