Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132244AbQL1Bt7>; Wed, 27 Dec 2000 20:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132260AbQL1Btt>; Wed, 27 Dec 2000 20:49:49 -0500
Received: from p3EE3C826.dip.t-dialin.net ([62.227.200.38]:20996 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S132244AbQL1Btb>; Wed, 27 Dec 2000 20:49:31 -0500
Date: Thu, 28 Dec 2000 02:18:59 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.19pre3
Message-ID: <20001228021859.A4661@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E149GRm-0003sX-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E149GRm-0003sX-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Dec 22, 2000 at 00:52:32 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Somewhat late, but not too late; Alan Cox wrote:

> 2.2.19pre1
...
> o	VIA686a timer reset to 18Hz background		(Vojtech Pavlik)

I patched my 2.2.18-ma2 with that patch to see if that helps me off my
sys time slowness, but it does unfortunately not help.

I have my system clock drift roughly -1 s/min, though my CMOS clock is
fine unless tampered with.

What can I do?

-- 
Matthias Andree
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
