Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266469AbRG1HiH>; Sat, 28 Jul 2001 03:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266448AbRG1Hh5>; Sat, 28 Jul 2001 03:37:57 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:64270 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S266469AbRG1Hhp>; Sat, 28 Jul 2001 03:37:45 -0400
Message-ID: <3B626B81.49E25A39@namesys.com>
Date: Sat, 28 Jul 2001 11:36:33 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "A. Lehmann" <"pcg( Marc)"@goof.com>,
        Joshua Schmidlkofer <menion@srci.iwpsd.org>,
        kernel <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <E15QFoT-0006fY-00@the-village.bc.nu>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Alan Cox wrote:
> 
> > By the way, how about considering the use of tests before redhat coders put stuff in the linux
> > kernel?  You know, if VFS changes actually got tested before users encountered things like Viro
> > breaking ReiserFS in 2.4.5, it would be nice.
> > At Namesys, like all normal software shops, we actually run a test suite before shipping code
> > externally.  We usually try to require that it be tested by at least one person in addition to the
> > code author.
> 
> *PLONK*
> 
> No doubt if Namesys ran test suites all the tail merging bug fiasco and the
> directory/tree balance races wouldnt have happened.
Our test suites need much improvement, but we do have them and use them.  Can you say the same?

Hans
