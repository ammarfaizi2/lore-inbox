Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282769AbRLBGDt>; Sun, 2 Dec 2001 01:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282768AbRLBGDh>; Sun, 2 Dec 2001 01:03:37 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:43142 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S282769AbRLBGDY>;
	Sun, 2 Dec 2001 01:03:24 -0500
Message-ID: <3C09C414.5D9C9CAE@pobox.com>
Date: Sat, 01 Dec 2001 22:03:00 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16-1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Charles-Edouard Ruault <ce@ruault.com>
CC: stephane@tuxfinder.org, Jeff Merkey <jmerkey@timpanogas.org>,
        linux-kernel@vger.kernel.org
Subject: Re: File system Corruption with 2.4.16
In-Reply-To: <3C0954D5.6AA3532B@ruault.com> <3C09580F.5F323195@pobox.com> <3C095B0B.7EA478C1@ruault.com> <003601c17ac2$7a8dec10$f5976dcf@nwfs> <3C096DB3.204CE41C@pobox.com> <001e01c17acb$a44b69c0$f5976dcf@nwfs> <20011202023145.A1628@emeraude.kwisatz.net> <3C09B3FA.61777E84@ruault.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Charles-Edouard Ruault wrote:

> The symlink problem you're reporting is exactly what i've been experiencing among
> other things ...
> on both systems i had multiple ext2 partitions and one reseirfs partition.
> The problem showed up after a few days of uptime. Both machines where not heaviliy
> loaded and had no memory shortage.
> It looks like it also happened on my third system, which had only 2 ext2 partitions
> . I was able to clean up this one with fsck and rebooted safely to 2.4.14 ....
> Given the fact that i'm not the only one to see the problem with 2.4.16 i'll safely
> backtrack all my machines to 2.4.14 ...
> If i can be of any help to pinpoint the problem please let me know. But since i'm
> not a kernel hacker i don't think i'll be pluging into the sources myself on my own

Interesting - maybe I'm just lucky, but my
systems have never been more stable than
they are now under 2.4.16 -

The plot thickens!

jjs

