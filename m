Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131750AbRA2PIi>; Mon, 29 Jan 2001 10:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131777AbRA2PIa>; Mon, 29 Jan 2001 10:08:30 -0500
Received: from aragorn.ics.muni.cz ([147.251.4.33]:13288 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S131750AbRA2PIO>; Mon, 29 Jan 2001 10:08:14 -0500
Newsgroups: cz.muni.redir.linux-kernel
Path: news
From: Zdenek Kabelac <kabi@fi.muni.cz>
Subject: Re: ps hang in 241-pre10
Message-ID: <3A758759.83196BB2@fi.muni.cz>
Date: Mon, 29 Jan 2001 15:08:09 GMT
To: Linus Torvalds <torvalds@transmeta.com>
X-Nntp-Posting-Host: dual.fi.muni.cz
Content-Transfer-Encoding: 7bit
X-Accept-Language: Czech, en
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <94voof$17j$1@penguin.transmeta.com>
Mime-Version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac9 i686)
Organization: unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> In article <3A7359BB.7BBEE42A@linux.com>, David Ford  <david@linux.com>
> wrote:
> >
> >We've narrowed it down to "we're all running xmms" when it happend.
> 
> Does anybody have a clue about what is different with xmms?
> 
> Does it use KNI if it can, for example? We used to have a problem with

Seeing this - I'll add my post here too - I've been burning one audio CD
last week and while I've been moving slider the system has locked  - I
think
the kernel version has been -ac7 - then I've used pre8 and I've been
playing divx file while burning four other CD with no problem.

My system is SMP Bp6 with SBLive kernel's emu driver.

-- 
             There are three types of people in the world:
               those who can count, and those who can't.
  Zdenek Kabelac  http://i.am/kabi/ kabi@i.am {debian.org; fi.muni.cz}

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
