Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131947AbRA0JQs>; Sat, 27 Jan 2001 04:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132166AbRA0JQi>; Sat, 27 Jan 2001 04:16:38 -0500
Received: from gw-enternet.enternet.se ([193.13.79.17]:8329 "HELO
	mail.ornskoldsvik.com") by vger.kernel.org with SMTP
	id <S131947AbRA0JQX>; Sat, 27 Jan 2001 04:16:23 -0500
Message-ID: <3A72921C.D013F074@sorliden.ornskoldsvik.com>
Date: Sat, 27 Jan 2001 10:17:17 +0100
From: Matti Långvall 
	<matti.langvall@sorliden.ornskoldsvik.com>
Reply-To: matti.langvall@sorliden.ornskoldsvik.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac11 i686)
X-Accept-Language: sv, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Running 2.4.0-ac11
In-Reply-To: <3A720485.58D656A4@sorliden.ornskoldsvik.com> <20010127015122.E23160@suse.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

> On Sat, Jan 27 2001, Matti Långvall wrote:
> > Best developers,
> >
> > I was told to send you these lines by Mr. Marcelo Tosatti, they appear
> > even though there is no CD in any drive.
> > System:    P3 733, VIA chips, 2 HD IDE drives, DVD and CD-R
> >
> > Jan 26 23:44:16 h-10-26-17-2 last message repeated 25 times
> > Jan 26 23:44:47 h-10-26-17-2 kernel: scsi : aborting command due to
> > timeout : pid 0, scsi0, channel 0, id 1, lun 0 0x03 00 00 00 40 00
> > Jan 26 23:44:55 h-10-26-17-2 kernel: VFS: busy inodes on changed media.
> > Jan 26 23:44:55 h-10-26-17-2 kernel: VFS: busy inodes on changed media.
> > Jan 26 23:44:55 h-10-26-17-2 kernel: attempt to access beyond end of
> > device
> > Jan 26 23:44:55 h-10-26-17-2 kernel: 0b:01: rw=0, want=34, limit=2
> > Jan 26 23:44:55 h-10-26-17-2 kernel: isofs_read_super: bread failed,
> > dev=0b:01, iso_blknum=16, block=16
> > Jan 26 23:44:57 h-10-26-17-2 kernel: VFS: busy inodes on changed media.
> > Jan 26 23:45:29 h-10-26-17-2 last message repeated 32 times
> > Jan 26 23:46:31 h-10-26-17-2 last message repeated 62 times
> > Jan 26 23:47:32 h-10-26-17-2 last message repeated 60 times
> > Jan 26 23:48:34 h-10-26-17-2 last message repeated 62 times
> > Jan 26 23:49:36 h-10-26-17-2 last message repeated 62 times
>
> Running magicdev by any chance?
>
> rpm -e magicdev
>
> --
> * Jens Axboe <axboe@suse.de>
> * SuSE Labs

YES

magicdev -0.2.7-1

That's it?

Matti Långvall


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
