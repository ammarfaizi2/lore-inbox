Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132536AbRBRCK7>; Sat, 17 Feb 2001 21:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132587AbRBRCKt>; Sat, 17 Feb 2001 21:10:49 -0500
Received: from [63.109.146.2] ([63.109.146.2]:46070 "EHLO mail0.myrio.com")
	by vger.kernel.org with ESMTP id <S132536AbRBRCKi>;
	Sat, 17 Feb 2001 21:10:38 -0500
Message-ID: <4461B4112BDB2A4FB5635DE199587432022422@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: "'hps@intermeta.de'" <hps@intermeta.de>,
        Jean Francois Micouleau <Jean-Francois.Micouleau@dalalu.fr>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Linux stifles innovation...
Date: Sat, 17 Feb 2001 18:10:31 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Henning P. Schmiedehausen wrote:

> ... If you
> write for Windows, you have an ugly and complicated API with lots of
> bugs

Yes, that is true.

> , but the API itself is stable since six (!) years.  You can write
> programs that run on 95/98/ME/NT/2000 unchanged. 

That is not always true, as I learned by painful, repeated experience.

My previous job, and some contract work I have done, involved writing 
software for Windows.  My WORST problems were incompatibilities between 
Windows NT and Windows 95.  The APIs do NOT, I repeat NOT! NOT! NOT! 
work the same on the various Windows flavors, as soon as you start 
doing non-trivial applications.  Three times at least, portability
problems from NT to Win95 cost me sleepless nights.  Debugging stuff
like that is hell when you don't have the source.

And when things break on Win95 where they ran on NT, what do you do,
run a debugger on Win95, where a crash can (and will) bring down the 
whole system?  Ugh, the horror.

Linux is not perfect yet, and there may be incompatibilities between 
library versions. But with the source, I have always been able to 
debug and fix the problems I've run into with much less pain than 
I ever had on Windows.  I'm never going back.

Yours, 

Torrey Hoffman
