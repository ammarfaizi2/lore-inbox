Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261745AbSIPNdP>; Mon, 16 Sep 2002 09:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261786AbSIPNdO>; Mon, 16 Sep 2002 09:33:14 -0400
Received: from cibs9.sns.it ([192.167.206.29]:39179 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S261745AbSIPNdN>;
	Mon, 16 Sep 2002 09:33:13 -0400
Date: Mon, 16 Sep 2002 15:37:58 +0200 (CEST)
From: venom@sns.it
To: louie miranda <louie@chikka.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Hi is this critical?? 
In-Reply-To: <006301c25d85$5bfcc180$0b00000a@nocpc3>
Message-ID: <Pine.LNX.4.43.0209161537200.5180-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


yes, this is critical.
It means that your HD is going to break soon.

Luigi

On Mon, 16 Sep 2002, louie miranda wrote:

> Date: Mon, 16 Sep 2002 21:31:18 +0800
> From: louie miranda <louie@chikka.com>
> To: linux-kernel@vger.kernel.org
> Subject: Hi is this critical??
>
> Is this critical??
> I have this error's over my kern.log file and when i type dmesg..
> Whats this all about? HD problems or some kernel conflict?
>
>
> --
> dmesg
> db: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hdb: dma_intr: error=0x40 { UncorrectableError }, LBAsect=14912550,
> sector=10719504
> end_request: I/O error, dev 03:42 (hdb), sector 10719504
> --
>
>
> --
> kern.log
> May 29 18:03:58 euclid ls[55] exited with preempt_count 9
> May 29 18:03:58 euclid depscan.sh[54] exited with preempt_count 2
> May 29 18:03:58 euclid ls[219] exited with preempt_count 1
> May 29 18:03:58 euclid ls[409] exited with preempt_count 1
> May 29 18:03:58 euclid depscan.sh[31] exited with preempt_count 76
> May 29 18:03:58 euclid Adding Swap: 2096472k swap-space (priority -1)
> May 29 18:03:58 euclid Adding Swap: 2096440k swap-space (priority -2)
> May 29 18:03:58 euclid swapon[942] exited with preempt_count 3
> May 29 18:03:58 euclid dmesg[943] exited with preempt_count 2
> May 29 18:03:58 euclid ls[947] exited with preempt_count 1
> --
>
>
>
> Thanks,
> Louie...
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

