Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318769AbSICNAZ>; Tue, 3 Sep 2002 09:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318770AbSICNAZ>; Tue, 3 Sep 2002 09:00:25 -0400
Received: from mail.iolinc.net ([206.102.147.2]:29447 "EHLO
	iolmail.camelot.iolinc.net") by vger.kernel.org with ESMTP
	id <S318769AbSICNAY>; Tue, 3 Sep 2002 09:00:24 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Gene Heskett <gene_heskett@iolinc.net>
Organization: None that appears to be detectable by casual observers
To: kde-linux@mail.kde.org, Jerry McBride <mcbrides9@comcast.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       "kde-linux@mail.kde.org" <kde-linux@mail.kde.org>
Subject: Re: [kde-linux] Can't find qt libs...
Date: Tue, 3 Sep 2002 09:04:49 -0400
User-Agent: KMail/1.4.2
References: <0H1V0080X1S3C3@mtaout03.icomcast.net>
In-Reply-To: <0H1V0080X1S3C3@mtaout03.icomcast.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200209030904.49101.gene_heskett@iolinc.net>
X-Note: This E-mail was scanned by Declude JunkMail (www.declude.com) for spam.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 September 2002 07:48, Jerry McBride wrote:
>Why is it that after I successfully compile qt3 and kde3.0.x...
> that I can never go back and
>recompile the beast without kde's ./configure scripts not being
> able to find qt3?? it acts like a
>onetime shot at compiling and then never again.
>
>It's a pain in the ass. What's the skinny, if any one knows?

And its not just kde. I have several things that won't configure 
because the *&%&^%$ libqt-mt.so in >= qt-3.0.2 can't be found.  
There are 4 copies of 3.0.4 scattered about my system.  Its a real 
problem that so far evertone seems to think will go away if our 
$QTDIR is set correctly, and/or we use the --with-qt-libs= options.

It doesn't go away no matter how much the rest of this list wishes 
*we* would.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.13% setiathome rank, not too shabby for a WV hillbilly
