Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280126AbRKECWJ>; Sun, 4 Nov 2001 21:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280122AbRKECV7>; Sun, 4 Nov 2001 21:21:59 -0500
Received: from a904j637.tower.wayne.edu ([141.217.140.65]:49653 "HELO
	mail.outstep.com") by vger.kernel.org with SMTP id <S280126AbRKECVq>;
	Sun, 4 Nov 2001 21:21:46 -0500
To: linux-kernel@vger.kernel.org
Subject: Special Kernel Modification Results
Message-ID: <1004926188.3be5f4ec7e622@mail.outstep.com>
Date: Sun, 04 Nov 2001 21:09:48 -0500 (EST)
From: lonnie@outstep.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.5
X-Originating-IP: 192.168.1.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

I just wanted to say thanks to everyone for the help and I think that I will be
able to figure out some nice solution based upon all of the suggestions given to me.

Originally I thought that this might be a kernel issue in that we could make a
filesystem to handle this problem, but now I see that there has to be another
solution.

It is nice that in Linux a person can easily set permissions to prevent someone
from entering a particular directory, but for the special projects when you want
to somehow confine them to their HOME directory then the standard permissions
are somewhat illsuited for the task.

There is always the problem of being able to see the binaries from the users
directories if you were to lock them in.

In any case, I am thinking that a combination of chroot and hard-links might do
the trick.

Thanks again to all,
Lonnie 
