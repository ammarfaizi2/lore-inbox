Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133113AbREHTB4>; Tue, 8 May 2001 15:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135206AbREHTBq>; Tue, 8 May 2001 15:01:46 -0400
Received: from jupter.networx.com.br ([200.187.100.102]:28288 "EHLO
	jupter.networx.com.br") by vger.kernel.org with ESMTP
	id <S133113AbREHTBc> convert rfc822-to-8bit; Tue, 8 May 2001 15:01:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: Thiago Vinhas de Moraes <tvinhas@networx.com.br>
Organization: Networx - A SuaCompanhia.com
To: Jens Axboe <axboe@suse.de>, Ben Fennema <bfennema@ix.netcom.com>
Subject: Re: write to dvd ram
Date: Tue, 8 May 2001 15:59:46 -0300
X-Mailer: KMail [version 1.2]
Cc: cacook@freedom.net, linux-kernel@vger.kernel.org
In-Reply-To: <91FD33983070D21188A10008C728176C09421202@LDMS6003> <20010508100129.19740@dragon.linux.ix.netcom.com> <20010508195030.J505@suse.de>
In-Reply-To: <20010508195030.J505@suse.de>
MIME-Version: 1.0
Message-Id: <01050815594606.01919@zeus>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

Can this new UDF driver do cd-rewriting ?



Em Ter 08 Mai 2001 14:50, Jens Axboe escreveu:
> On Tue, May 08 2001, Ben Fennema wrote:
> > > The log is:
> > > Apr 15 20:58:27 hydra kernel: UDF-fs INFO UDF 0.9.1 (2000/02/29)
> > > Mounting volume 'UDF Volume', timestamp 2001/03/02 11:55 (1e98)
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

-- 
________________________________
 Thiago Vinhas de Moraes
 NetWorx - A SuaCompanhia.com
