Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264508AbRFOUOT>; Fri, 15 Jun 2001 16:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264509AbRFOUOJ>; Fri, 15 Jun 2001 16:14:09 -0400
Received: from logger.gamma.ru ([194.186.254.23]:35844 "EHLO logger.gamma.ru")
	by vger.kernel.org with ESMTP id <S264508AbRFOUNv>;
	Fri, 15 Jun 2001 16:13:51 -0400
To: linux-kernel@vger.kernel.org
Path: pccross!not-for-mail
From: crosser@average.org (Eugene Crosser)
Newsgroups: linux.kernel
Subject: Re: 2.4.5 data corruption
Date: 15 Jun 2001 23:54:20 +0400
Organization: Average
Message-ID: <9gdp5c$pj$1@pccross.average.org>
In-Reply-To: <E15Afvk-0005aV-00@the-village.bc.nu>
Mime-Version: 1.0
X-Newsreader: knews 0.9.8
X-Comment-To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset=koi8-r
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E15Afvk-0005aV-00@the-village.bc.nu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
>> any problems since 2.4.5 was published, they seem to have surfaced
>> immediately after I created a rather big file capturing video with
>> broadcast2000 (video card is bt848).  Filesystem is ext2.
> 
> Thats something I've seen reported elsehwere. The high bandwidth capture card
> stuff seems to show up problems. It could be drivers could be hardware. On
> my AMD 751 pre release board I see that problem but on the 751 production board
> I dont

You must be right, today I created another big file with the same program
but without doing caputre and the filesystem was intact.  OTOH,
Russell Leighton reports curruption when creating a file with dd...

Eugene
