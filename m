Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272131AbRHVVpR>; Wed, 22 Aug 2001 17:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272134AbRHVVpH>; Wed, 22 Aug 2001 17:45:07 -0400
Received: from [66.52.6.235] ([66.52.6.235]:50583 "EHLO puddy.travisshirk.net")
	by vger.kernel.org with ESMTP id <S272131AbRHVVpD>;
	Wed, 22 Aug 2001 17:45:03 -0400
Date: Wed, 22 Aug 2001 15:46:29 -0600 (MDT)
From: Travis Shirk <travis@pobox.com>
X-X-Sender: <travis@puddy.travisshirk.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Locking Up
In-Reply-To: <E15ZbjI-0001s2-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0108221544290.1152-100000@puddy.travisshirk.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2001, Alan Cox wrote:

>> The symptons are total lock-up of the machine.  No mouse
>> movement, all GUI monoitors freeze, and I cannot switch to a
>> virtual console.  I'm not able to ping the locked machine or
>> ssh/telnet into it either.  So I'm left wondering....how and
>> the hell to I debug this problem.  It'd be nice to have some
>> more information to go on or post to the list.
>
>Can you get it to crash when you are not in X11 at all ?

I have not, but I do not spend too much time outside of
the GUI.  I don't boot into X, so unless I'm logged out
X is running.

Travis
-- 
Travis Shirk <travis at pobox dot com>
Mathematics is God and Knuth is our prophet.

