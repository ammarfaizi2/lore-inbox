Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130370AbRA0LSG>; Sat, 27 Jan 2001 06:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131977AbRA0LR4>; Sat, 27 Jan 2001 06:17:56 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:19974 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S130370AbRA0LRs>;
	Sat, 27 Jan 2001 06:17:48 -0500
Date: Sat, 27 Jan 2001 12:17:42 +0100
From: Jens Axboe <axboe@suse.de>
To: Matti Långvall 
	<matti.langvall@sorliden.ornskoldsvik.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Running 2.4.0-ac11
Message-ID: <20010127121742.A27553@suse.de>
In-Reply-To: <3A720485.58D656A4@sorliden.ornskoldsvik.com> <20010127015122.E23160@suse.de> <3A72921C.D013F074@sorliden.ornskoldsvik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3A72921C.D013F074@sorliden.ornskoldsvik.com>; from matti.langvall@sorliden.ornskoldsvik.com on Sat, Jan 27, 2001 at 10:17:17AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 27 2001, Matti Långvall wrote:
> > > Jan 26 23:44:57 h-10-26-17-2 kernel: VFS: busy inodes on changed media.
> > > Jan 26 23:45:29 h-10-26-17-2 last message repeated 32 times
> > > Jan 26 23:46:31 h-10-26-17-2 last message repeated 62 times
> > > Jan 26 23:47:32 h-10-26-17-2 last message repeated 60 times
> > > Jan 26 23:48:34 h-10-26-17-2 last message repeated 62 times
> > > Jan 26 23:49:36 h-10-26-17-2 last message repeated 62 times
> >
> > Running magicdev by any chance?
> >
> > rpm -e magicdev
> >
> 
> YES
> 
> magicdev -0.2.7-1
> 
> That's it?

You tell me, do the errors disappear if you remove this package?

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
