Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129410AbQLBRdl>; Sat, 2 Dec 2000 12:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129413AbQLBRdb>; Sat, 2 Dec 2000 12:33:31 -0500
Received: from [194.213.32.137] ([194.213.32.137]:1028 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129410AbQLBRdO>;
	Sat, 2 Dec 2000 12:33:14 -0500
Message-ID: <20001202175035.A253@bug.ucw.cz>
Date: Sat, 2 Dec 2000 17:50:35 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
Cc: "Henning P. Schmiedehausen" <hps@tanstaafl.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Fasttrak100 questions...
In-Reply-To: <Pine.LNX.4.21.0011291152500.5109-100000@sol.compendium-tech.com> <E141E3Y-0006Lb-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <E141E3Y-0006Lb-00@the-village.bc.nu>; from Alan Cox on Wed, Nov 29, 2000 at 08:42:18PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > You are wrong: If you modify the kernel you have to make it available for
> > anyone who wishes to use it; that's also in the GPL. You can't add stuff
> 
> No it isnt. Some people seem to think it is. You only have to provide a 
> change if you give someone the binaries concerned. Some people also think
> that 'linking' clauses mean they can just direct the customer to do the link,
> that also would appear to be untrue in legal precedent - the law cares about
> the intent.

This is currently happening with lucent winmodem driver: there's
modified version of serial.c, and customers are asked to compile it
and (staticaly-)link it against proprietary code to get usable
driver. Is that okay or not?
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
