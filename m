Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133067AbREHSMJ>; Tue, 8 May 2001 14:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133040AbREHSL7>; Tue, 8 May 2001 14:11:59 -0400
Received: from relay.freedom.net ([207.107.115.209]:26891 "HELO
	relay.freedom.net") by vger.kernel.org with SMTP id <S133062AbREHSL5>;
	Tue, 8 May 2001 14:11:57 -0400
X-Freedom-Envelope-Sig: linux-kernel@vger.kernel.org AQHIyBoVSEV6fqLNUl/zQRTpKiDLgMFiBekAEvgaqHsCqinr95Krr69b
Date: Tue, 08 May 2001 12:11:26 -0600
Old-From: cacook@freedom.net
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Ben Fennema <bfennema@ix.netcom.com>, linux-kernel@vger.kernel.org
Subject: Re: write to dvd ram
In-Reply-To: <91FD33983070D21188A10008C728176C09421202@LDMS6003> <20010508145400Z132655-406+505@vger.kernel.org> <20010508100129.19740@dragon.linux.ix.netcom.com> <20010508195030.J505@suse.de>
Content-Type: text/plain; charset = "us-ascii" 
Content-Transfer-Encoding: 7bit
From: cacook@freedom.net
Message-Id: <20010508181158Z133062-406+575@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, I'll try it.  Didn't get the prior response.
--
C.

The best way out is always through.
      - Robert Frost  A Servant to Servants, 1914



Jens Axboe wrote:

> On Tue, May 08 2001, Ben Fennema wrote:
> > > The log is:
> > > Apr 15 20:58:27 hydra kernel: UDF-fs INFO UDF 0.9.1 (2000/02/29) Mounting
> > > volume 'UDF Volume', timestamp 2001/03/02 11:55 (1e98)
> >
> > At the very least, run 0.9.3 from sourceforce (or the cvs version) and
> > see if it works any better.
>
> I was just about to say the same thing, 0.9.3 works well for me. In fact
> so well, that I made a patch to bring 2.4.5-pre1 UDF up to date with
> current CVS earlier this afternoon (hint hint, Ben :-).
>
> *.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.5-pre1/
>
> udf-0.9.3-2.4.5p1-1.bz2
>
> --
> Jens Axboe




