Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317623AbSFNPtD>; Fri, 14 Jun 2002 11:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317628AbSFNPtC>; Fri, 14 Jun 2002 11:49:02 -0400
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.227]:4010 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S317623AbSFNPtB>; Fri, 14 Jun 2002 11:49:01 -0400
Message-ID: <3D0A0EEF.5070700@linuxhq.com>
Date: Fri, 14 Jun 2002 11:42:39 -0400
From: John Weber <john.weber@linuxhq.com>
Organization: Linux Headquarters
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>, Martin Dalecki <dalecki@evision-ventures.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 IDE 91
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com> <3D09F769.8090704@evision-ventures.com> <20020614151703.GB1120@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  > And finally a small plea for more testing. Do you even test before
> blindly sending patches off to Linus?! Sometimes just watching how
> quickly these big patches appears makes it impossible that they have
> gotten any kind of testing other than the 'hey it compiles', which I
> think it just way too little for something that could possible screw
> peoples data up very badly. Frankly, _I'm_ too scared to run 2.5 IDE
> currently. The success ratio of posted over working patches is too big.

I run all all of Martin's patches on my machine, and I haven't run into
any catastrophic problems (by this I mean problems that cause data loss 
though I realize that this may not be much of a standard).

I rather like the fact that Martin releases early and often... it 
usually means that I get a fix right away. I like the "release early and 
often" approach in a development kernel branch since I do not believe 
that releasing less often has any correlation to the stability of the 
product released (look at Windows :).

Martin or Jens, are there any test suites that you would like me to run?

I am currently too stupid to be able to aid in the development directly 
(lord knows i'm trying to get up to speed), but, in the meantime, I can 
test the crap out of a kernel :).

  -o)  J o h n   W e b e r
  /\\ john.weber@linuxhq.com
_\/v http://www.linuxhq.com/people/weber/

