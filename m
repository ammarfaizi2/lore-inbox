Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268973AbRG0VPB>; Fri, 27 Jul 2001 17:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268975AbRG0VOv>; Fri, 27 Jul 2001 17:14:51 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:36368 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S268973AbRG0VOg>; Fri, 27 Jul 2001 17:14:36 -0400
Message-ID: <3B61D980.F623AC5A@namesys.com>
Date: Sat, 28 Jul 2001 01:13:36 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: "A. Lehmann" <"pcg( Marc)"@goof.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Joshua Schmidlkofer <menion@srci.iwpsd.org>,
        kernel <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <no.id> <E15Q9Bw-0005q5-00@the-village.bc.nu> <20010727224649.B6357@fuji.laendle>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

"pcg( Marc)"@goof(A.).(Lehmann )com wrote:

> > No. The only thing I can think of that might slow it is that we build with
> > the reiserfs paranoia/sanity checks on.
> 
> That's a pretty dumb thing. Maybe one should have asked the develoers
> before doing this (they never do). Redhat somehow manages pretty well to
> show reiserfs in a bad light ;)

Let us be a bit more precise here.  If you click on the help button when deciding whether to select
that option it tells you not to do it.  What can you say about a distro that doesn't read the help
buttons for the kernel options when configuring the kernel?  Shovelware?

Hans
