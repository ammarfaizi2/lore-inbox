Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276729AbRJHAyS>; Sun, 7 Oct 2001 20:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276734AbRJHAx6>; Sun, 7 Oct 2001 20:53:58 -0400
Received: from [213.97.199.90] ([213.97.199.90]:35456 "HELO fargo")
	by vger.kernel.org with SMTP id <S276729AbRJHAx4> convert rfc822-to-8bit;
	Sun, 7 Oct 2001 20:53:56 -0400
From: "David =?ISO-8859-1?Q?G=F3mez" ?= <davidge@jazzfree.com>
Date: Mon, 8 Oct 2001 02:51:32 +0200 (CEST)
X-X-Sender: <huma@fargo>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Riley Williams <rhw@MemAlpha.CX>,
        David =?unknown-8bit?Q?G=F3mez?= <davidge@jazzfree.com>,
        Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: IDE DMA errors [was: Some ext2 errors]
In-Reply-To: <20011007173237.A30930@mikef-linux.matchmail.com>
Message-ID: <Pine.LNX.4.33.0110080240060.1690-100000@fargo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> [...]
>
> But we don't know what is happening with David's system.
>
> To rule out some possible causes David, you should run these tests:
> memtest86 (www.memtest86.org
> badblocks -s /dev/hda (read only hard drive test, newer versions have a -p
> option for safe write mode tests too)

I checked yesterday the memory with memtest86, no errors, and i don't
think the problem is caused by some bad blocks. Using another disk, which
contains and ext3 partition, gave me another strange error (different from
the ext2 one i posted to the list) with the ide drive handling, and it
appeared only one time. So i think the guess that the problem is caused by
the power supply is right..., so i'll get a new one and let's see if the
problem doesn't show anymore ;)


Thanks




David Gómez

"The question of whether computers can think is just like the question of
 whether submarines can swim." -- Edsger W. Dijkstra


