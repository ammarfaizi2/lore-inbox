Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282778AbRLBGJ5>; Sun, 2 Dec 2001 01:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282781AbRLBGJt>; Sun, 2 Dec 2001 01:09:49 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:48518 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S282778AbRLBGJj>;
	Sun, 2 Dec 2001 01:09:39 -0500
Message-ID: <3C09C564.6C54B51F@pobox.com>
Date: Sat, 01 Dec 2001 22:08:36 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16-1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: stephane@tuxfinder.org
CC: Jeff Merkey <jmerkey@timpanogas.org>,
        Charles-Edouard Ruault <ce@ruault.com>, linux-kernel@vger.kernel.org
Subject: Re: File system Corruption with 2.4.16
In-Reply-To: <3C0954D5.6AA3532B@ruault.com> <3C09580F.5F323195@pobox.com> <3C095B0B.7EA478C1@ruault.com> <003601c17ac2$7a8dec10$f5976dcf@nwfs> <3C096DB3.204CE41C@pobox.com> <001e01c17acb$a44b69c0$f5976dcf@nwfs> <20011202023145.A1628@emeraude.kwisatz.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephane Jourdois wrote:

> I destroyed a  hard  disk  yesterday  with  2.4.16,  using  ext3.  A  heavy load
> (compiling The gimp and several other things)  and everything came bad, symlinks
> didn't work... (for exemple ln -s linux-2.4.17-pre2  linux did a link from linux
> to linux either using linux-2.4.17-pre2 and /usr/src/linux-2.4.17-pre2.

hmm, I am using ext3 in a few places, but
for the most part I am using the tried and
true ext2 -

> Just in case : debian sid, gcc 2.95.4, everything up to date.

Another difference -
I am using the rock solid gcc-2.96!

> We're living in a dangerous world, since 2.4.10...

Since 2.4.10, my systems have been great!

(I administer about 40 Linux boxes)

cu

jjs

