Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267691AbTAMApY>; Sun, 12 Jan 2003 19:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267694AbTAMApY>; Sun, 12 Jan 2003 19:45:24 -0500
Received: from air-2.osdl.org ([65.172.181.6]:63682 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267691AbTAMApX>;
	Sun, 12 Jan 2003 19:45:23 -0500
From: Randy Dunlap <rddunlap@osdl.org>
Message-ID: <1831.4.64.197.173.1042419253.squirrel@www.osdl.org>
Date: Sun, 12 Jan 2003 16:54:13 -0800 (PST)
Subject: Re: any chance of 2.6.0-test*?
To: <sneakums@zork.net>
In-Reply-To: <6uk7haxg72.fsf@zork.zork.net>
References: <Pine.LNX.4.44.0301121134340.14031-100000@home.transmeta.com>
        <1042401596.1209.51.camel@RobsPC.RobertWilkens.com>
        <200301122018.h0CKIcWN004203@turing-police.cc.vt.edu>
        <6uk7haxg72.fsf@zork.zork.net>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> commence  Valdis.Kletnieks@vt.edu quotation:
>
>> The real problem is that C doesn't have a good multi-level "break"
>> construct.  On the other hand, I don't know of any language that has a
>> good one - some allow "break 3;" to break 3 levels- but that's still bad
>> because you get screwed if somebody adds an 'if'
>> clause....
>
> Perl's facility for labelling blocks and jumping to the beginning or end
> with 'next' and 'last' may be close to what you want, but I don't know if
> it's ever been implemented in a language one could sensibly use to write a
> kernel.


Yes, Burroughs (who?) implemented it in System Development Language
(SDL) more than 20 years ago.  Worked very well.

~Randy  (I hope I don't find more of this thread to reply to. :(



