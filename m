Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285130AbRLFNRl>; Thu, 6 Dec 2001 08:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285129AbRLFNRb>; Thu, 6 Dec 2001 08:17:31 -0500
Received: from web13902.mail.yahoo.com ([216.136.175.28]:13321 "HELO
	web13902.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S285130AbRLFNRO>; Thu, 6 Dec 2001 08:17:14 -0500
Message-ID: <20011206131713.15051.qmail@web13902.mail.yahoo.com>
Date: Thu, 6 Dec 2001 05:17:13 -0800 (PST)
From: Jorge Carminati <jcarminati@yahoo.com>
Subject: Re: Kernel freezing....
To: linux-kernel@vger.kernel.org
In-Reply-To: <E16Buao-00010V-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > The problem is that after a couple of minutes of use it starts to 
> > dump kernel messages, and it ends freezing completely. Almost all
> the 
> > time I ran in init 1 mode (single user).
> 
> That does look like ram problems. Either somethign scribbling on RAM
> it
> shouldnt or 



Thanks Alan, I´ll test tonight the ram with memtest86.

Any suggested setting for memtest86 ?.


> 
> > P.S.: The notebook works fine under Windows XP, just to discard a
> HW 
> > failure.
> 
> Proves nothing. Linux and Windows tend to allocate critical data in
> very
> different places in RAM. Give it an overnight run with memtest86 and
> see
> what pops up 

Ok, understood.

Regards,
Jorge Carminati.

P.S.: Please for any answer cc to jcarminati@yahoo.com


__________________________________________________
Do You Yahoo!?
Send your FREE holiday greetings online!
http://greetings.yahoo.com
