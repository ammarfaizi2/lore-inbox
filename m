Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130113AbRA0NaI>; Sat, 27 Jan 2001 08:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130950AbRA0N37>; Sat, 27 Jan 2001 08:29:59 -0500
Received: from gw-enternet.enternet.se ([193.13.79.17]:15490 "HELO
	mail.ornskoldsvik.com") by vger.kernel.org with SMTP
	id <S130113AbRA0N3s>; Sat, 27 Jan 2001 08:29:48 -0500
Message-ID: <3A72CD7B.62402916@sorliden.ornskoldsvik.com>
Date: Sat, 27 Jan 2001 14:30:35 +0100
From: Matti Långvall 
	<matti.langvall@sorliden.ornskoldsvik.com>
Reply-To: matti.langvall@sorliden.ornskoldsvik.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac12 i686)
X-Accept-Language: sv, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Running 2.4.0-ac11
In-Reply-To: <3A720485.58D656A4@sorliden.ornskoldsvik.com> <20010127015122.E23160@suse.de> <3A72921C.D013F074@sorliden.ornskoldsvik.com> <20010127121742.A27553@suse.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

> On Sat, Jan 27 2001, Matti Långvall wrote:
> > > > Jan 26 23:44:57 h-10-26-17-2 kernel: VFS: busy inodes on changed media.
> > > > Jan 26 23:45:29 h-10-26-17-2 last message repeated 32 times
> > > > Jan 26 23:46:31 h-10-26-17-2 last message repeated 62 times
> > > > Jan 26 23:47:32 h-10-26-17-2 last message repeated 60 times
> > > > Jan 26 23:48:34 h-10-26-17-2 last message repeated 62 times
> > > > Jan 26 23:49:36 h-10-26-17-2 last message repeated 62 times
> > >
> > > Running magicdev by any chance?
> > >
> > > rpm -e magicdev
> > >
> >
> > YES
> >
> > magicdev -0.2.7-1
> >
> > That's it?
>
> You tell me, do the errors disappear if you remove this package?
>
> --
> * Jens Axboe <axboe@suse.de>
> * SuSE Labs

You're right, no more Busy inodes.
But magicdev is nice for us lazy people..
Thanks

Matti L


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
