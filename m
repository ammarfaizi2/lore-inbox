Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288422AbSAXQGD>; Thu, 24 Jan 2002 11:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288639AbSAXQFy>; Thu, 24 Jan 2002 11:05:54 -0500
Received: from paloma17.e0k.nbg-hannover.de ([62.181.130.17]:8691 "HELO
	paloma17.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S288422AbSAXQFq>; Thu, 24 Jan 2002 11:05:46 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Norbert Preining <preining@logic.at>
Subject: Re: amd athlon cooling on kt266/266a chipset
Date: Thu, 24 Jan 2002 17:05:38 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Daniel Nofftz <nofftz@castor.uni-trier.de>,
        Ed Sweetman <ed.sweetman@wmich.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020124160551Z288422-13997+9459@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 24. January 2002 12:36, Norbert Preining wrote:
> On Don, 24 Jan 2002, Ed Sweetman wrote:
> > Furthermore, I haven't heard of anyone where the patch actually makes an
> > improvement in temp with the patch.  But i have heard of people saying
>
> Well, I am a counterexample. I used another patch doing the same
> (the one from www.vcool.de) and it reduced my CPU temp by around 15-20 C!
> In summer this can be of real good use!

I can second that.
You know that this thread was running for some time ([patch] amd athlon 
cooling on kt266/266a chipset).

Find below the best numbers I've ever seen (I resend them, here):

Athlon TB 1.2 GHz on MSI MS-6380 (KT7-Turbo-R):

idle mode with full VCool stuff under Win98SE
(you could watch the temperature drop in 5 sec (?) steps...;-)

~64°C => 29°-30°C

Case was somewhat below after that.

Regards,
	Dieter

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de
