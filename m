Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266479AbRGQNTX>; Tue, 17 Jul 2001 09:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266483AbRGQNTN>; Tue, 17 Jul 2001 09:19:13 -0400
Received: from aragorn.ics.muni.cz ([147.251.4.33]:59523 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S266479AbRGQNTG>; Tue, 17 Jul 2001 09:19:06 -0400
Newsgroups: cz.muni.redir.linux-kernel
Path: news
From: Zdenek Kabelac <kabi@i.am>
Subject: Re: Linux 2.4.6-ac3
Message-ID: <3B543B44.3004B185@i.am>
Date: Tue, 17 Jul 2001 13:19:00 GMT
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Nntp-Posting-Host: dual.fi.muni.cz
Content-Transfer-Encoding: 7bit
X-Accept-Language: cs, en
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E15Lnrk-00047x-00@the-village.bc.nu>
Mime-Version: 1.0
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-pre6-RTL3.0 i686)
Organization: unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > the 3 parts are changed for the fun of it.  Granted, issues of backwards
> > compatibility haven't been handled well in the past, but with the next
> > resync I believe that moving forward this will no longer be a problem.
> > You'd have to talk to the guys at VA about this, however.
> 
> Right but we cannot go around breaking support for older setups. A user
> updating their 2.4.x stable kernel and finding X11 no longer works simply isnt
> an acceptable situation for serious users.

Well only acceleration would not work as far as I know.
And if the user is tracking kernel development he probably also have
Xfree4.1
on his box.

I really think drm should be upgraded sooner than in 2.5 kernel.

kabi

BTW - will we ever see Vertical Blank Interrupt driver ?

