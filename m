Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263823AbRFIEHd>; Sat, 9 Jun 2001 00:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263797AbRFIEHX>; Sat, 9 Jun 2001 00:07:23 -0400
Received: from turnover.lancs.ac.uk ([148.88.17.220]:12026 "EHLO
	helium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id <S263772AbRFIEHM>; Sat, 9 Jun 2001 00:07:12 -0400
Message-Id: <l0313032cb7475100fc4a@[192.168.239.105]>
In-Reply-To: <Pine.LNX.4.33.0106090541370.480-100000@mikeg.weiden.de>
In-Reply-To: <l0313032bb7471092da13@[192.168.239.105]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 9 Jun 2001 05:05:41 +0100
To: Mike Galbraith <mikeg@wen-online.de>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: VM Report was:Re: Break 2.4 VM in five easy steps
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        John Stoffel <stoffel@casc.com>,
        Tobias Ringstrom <tori@unhappy.mine.nu>, Shane Nay <shane@minirl.com>,
        "Dr S.M. Huen" <smh1008@cus.cam.ac.uk>,
        Sean Hunter <sean@dev.sportingbet.com>,
        Xavier Bestel <xavier.bestel@free.fr>,
        lkml <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> On the subject of Mike Galbraith's kernel compilation test, how much
>> physical RAM does he have for his machine, what type of CPU is it, and what
>> (approximate) type of device does he use for swap?  I'll see if I can
>> partially duplicate his results at this end.  So far all my tests have been
>> done with a fast CPU - perhaps I should try the P166/MMX or even try
>> loading linux-pmac onto my 8100.
>
>It's a PIII/500 with one ide disk.

...with how much RAM?  That's the important bit.

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)

The key to knowledge is not to rely on people to teach you it.

GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)


