Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131747AbRA0AwE>; Fri, 26 Jan 2001 19:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131813AbRA0Avy>; Fri, 26 Jan 2001 19:51:54 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:9733 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S131747AbRA0Avk>;
	Fri, 26 Jan 2001 19:51:40 -0500
Date: Sat, 27 Jan 2001 01:51:22 +0100
From: Jens Axboe <axboe@suse.de>
To: Matti Långvall 
	<matti.langvall@sorliden.ornskoldsvik.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Running 2.4.0-ac11
Message-ID: <20010127015122.E23160@suse.de>
In-Reply-To: <3A720485.58D656A4@sorliden.ornskoldsvik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3A720485.58D656A4@sorliden.ornskoldsvik.com>; from matti.langvall@sorliden.ornskoldsvik.com on Sat, Jan 27, 2001 at 12:13:10AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 27 2001, Matti Långvall wrote:
> Best developers,
> 
> I was told to send you these lines by Mr. Marcelo Tosatti, they appear
> even though there is no CD in any drive.
> System:    P3 733, VIA chips, 2 HD IDE drives, DVD and CD-R
> 
> Jan 26 23:44:16 h-10-26-17-2 last message repeated 25 times
> Jan 26 23:44:47 h-10-26-17-2 kernel: scsi : aborting command due to
> timeout : pid 0, scsi0, channel 0, id 1, lun 0 0x03 00 00 00 40 00
> Jan 26 23:44:55 h-10-26-17-2 kernel: VFS: busy inodes on changed media.
> Jan 26 23:44:55 h-10-26-17-2 kernel: VFS: busy inodes on changed media.
> Jan 26 23:44:55 h-10-26-17-2 kernel: attempt to access beyond end of
> device
> Jan 26 23:44:55 h-10-26-17-2 kernel: 0b:01: rw=0, want=34, limit=2
> Jan 26 23:44:55 h-10-26-17-2 kernel: isofs_read_super: bread failed,
> dev=0b:01, iso_blknum=16, block=16
> Jan 26 23:44:57 h-10-26-17-2 kernel: VFS: busy inodes on changed media.
> Jan 26 23:45:29 h-10-26-17-2 last message repeated 32 times
> Jan 26 23:46:31 h-10-26-17-2 last message repeated 62 times
> Jan 26 23:47:32 h-10-26-17-2 last message repeated 60 times
> Jan 26 23:48:34 h-10-26-17-2 last message repeated 62 times
> Jan 26 23:49:36 h-10-26-17-2 last message repeated 62 times

Running magicdev by any chance?

rpm -e magicdev

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
