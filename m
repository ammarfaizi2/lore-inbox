Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133047AbQLIAZY>; Fri, 8 Dec 2000 19:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133075AbQLIAZO>; Fri, 8 Dec 2000 19:25:14 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:27411 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S133047AbQLIAZD>; Fri, 8 Dec 2000 19:25:03 -0500
Subject: Re: Linux 2.2.18pre25
To: M.Kacer@sh.cvut.cz (Martin Kacer)
Date: Fri, 8 Dec 2000 23:55:33 +0000 (GMT)
Cc: andrea@suse.de (Andrea Arcangeli), linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <Pine.LNX.4.30.0012081918130.7566-100000@duck.sh.cvut.cz> from "Martin Kacer" at Dec 08, 2000 07:30:28 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E144XMV-0004eN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    Well, I've found that VM-global patch before, of course. Until now, the
> last version was against pre18. Since I do not know the exact rules for
> including new things into Alan's tree, I thought that VM-global patch was
> already included in pre24. Sorry for my lack of experience. ;-)) I should
> have checked it.
>    As I wrote before, I had no time recently to follow the mailing list
> carefully and I didn't know exactly what VM-global patch is.
> 
> # >    It seems we need to return back to 2.2.13 for some time. :-(
> # Definitely no, you only need to apply the above collection of bugfixes.
> 
>    Ok, I can try it, at least.
>    I will let you know about results.

VM-global is currently on my 2.2.19pre pile of stuff. Im monitoring a few
cases with interest before I commit to that decision however

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
