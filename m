Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266440AbRGCFwP>; Tue, 3 Jul 2001 01:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266441AbRGCFvz>; Tue, 3 Jul 2001 01:51:55 -0400
Received: from 205-158-62-57.outblaze.com ([205.158.62.57]:12295 "HELO
	ws1-7.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S266440AbRGCFvv>; Tue, 3 Jul 2001 01:51:51 -0400
Message-ID: <20010703055145.29712.qmail@mail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Tha Phlash" <phlash4ce@techie.com>
To: linux-kernel@vger.kernel.org
Date: Tue, 03 Jul 2001 13:51:44 +0800
Subject: Re: [Re: gcc: internal compiler error: program cc1 got fatal
    signal 11]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ive also had a problem with signal 11, heres a great page explaining the aspects of signal 11 error from gcc (http://www.bitwizard.nl/sig11/).

Signal 11 is usually a hardware problem, as the article points out. I found a sloppy soulution playing with my BIOS settings, turns out there was an option called "Memory Hole at 15Mb Addr." I enabled it and i got no more sig11, however when I boot up, Linux only recognizes like 13Mb of my 64Mb of RAM. 

Anyway, there are my 2 cents.

Luis <phlash>
-- 

_______________________________________________
FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

FREE PC-to-Phone calls with Net2Phone
http://www.net2phone.com/cgi-bin/link.cgi?121





