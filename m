Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284587AbRLPLZr>; Sun, 16 Dec 2001 06:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284586AbRLPLZ2>; Sun, 16 Dec 2001 06:25:28 -0500
Received: from chmls16.mediaone.net ([24.147.1.151]:43174 "EHLO
	chmls16.mediaone.net") by vger.kernel.org with ESMTP
	id <S284584AbRLPLZZ>; Sun, 16 Dec 2001 06:25:25 -0500
Subject: Re: Problems downgrading from Kernel 2.4.8 to 2.2.20
From: jlm <jsado@mediaone.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <200112151109.MAA02201@harpo.it.uu.se>
In-Reply-To: <200112151109.MAA02201@harpo.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 16 Dec 2001 06:28:34 -0500
Message-Id: <1008502115.246.0.camel@PC2>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-12-15 at 06:09, Mikael Pettersson wrote:
> On Sat, 15 Dec 2001 00:50:44 +0100, Matthias Andree wrote:
> >> hda: lost interrupt
> >
> >That looks stranger. I'd suggest to try Andre's IDE patch from any
> >kernel.org mirror, /pub/linux/kernel/people/hedrick, but it seems
> >there's no 2.2.20 ide patch yet.
> 
> You can get my unofficial port of Hedrick's 2.2.19 IDE patch to 2.2.20
> at http://www.csd.uu.se/~mikpe/linux/ide.2.2.20.05042001.patch.bz2
Thanks! Your patch did the trick.

-- 
MACINTOSH = Machine Always Crashes If Not The Operating System Hangs
"Life would be so much easier if we could just look at the source code."
- Dave Olson

