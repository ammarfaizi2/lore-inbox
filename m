Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318756AbSHQWNU>; Sat, 17 Aug 2002 18:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318757AbSHQWNU>; Sat, 17 Aug 2002 18:13:20 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:24589 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318756AbSHQWNT>; Sat, 17 Aug 2002 18:13:19 -0400
Date: Sat, 17 Aug 2002 19:17:04 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Andre Hedrick <andre@linux-ide.org>, axboe@suse.de, vojtech@suse.cz,
       bkz@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: IDE?
Message-ID: <20020817221704.GA2478@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Anton Altaparmakov <aia21@cantab.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	Andre Hedrick <andre@linux-ide.org>, axboe@suse.de, vojtech@suse.cz,
	bkz@linux-ide.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0208161706390.1674-100000@home.transmeta.com> <Pine.LNX.4.44.0208161706390.1674-100000@home.transmeta.com> <5.1.0.14.2.20020817225323.021796b0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20020817225323.021796b0@pop.cus.cam.ac.uk>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Aug 17, 2002 at 11:11:14PM +0100, Anton Altaparmakov escreveu:
> At 20:56 17/08/02, Alan Cox wrote:
> >Volunteers willing to run Cerberus test sets on 2.4 boxes with IDE
> >controllers would also be much appreciated. That way we can get good
> >coverage tests and catch badness immediately

> If you tell me the kernel version and patches to apply which you want 
> tested, and what options to run cerberus with (never used it before...), I 
> have control over a currently idle dual Athlon MP 2000+ with an AMD-768 
> (rev 04) IDE controller and 3G of RAM. It has only one HD, a ST340810A 
> (ATA-100, 37G) attached.

I have a dual p100 with a CMD640 so I'll test 2.4-ac or whatever you name it,
as soon as I get back from vacation (in two weeks) and I get another old disk
for this test machine. It behaves with 2.4 but loses a lot of interrupts with
2.5-MD (haven't tested after Jens got 2.4 forward port into 2.5).

- Arnaldo
