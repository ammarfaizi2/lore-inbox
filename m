Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132383AbRAaQ40>; Wed, 31 Jan 2001 11:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132289AbRAaQ4Q>; Wed, 31 Jan 2001 11:56:16 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:19215 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S132356AbRAaQ4A>;
	Wed, 31 Jan 2001 11:56:00 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: J Brook <jbk@postmark.net>
Date: Wed, 31 Jan 2001 17:54:37 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Matrox G450 problems with 2.4.0 and xfree
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <142905C63D47@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 Jan 01 at 17:41, J Brook wrote:
> 
>  I don't have Windows installed on my machine, but I find that if I
> cold boot to 2.2 (RH7) first and start up X (4.0.2 with Matrox driver
> 1.00.04 compiled in), I am then able to "shutdown -r now" and warm

Yes, they use same secret code... At least I think...

> restart to 2.4 with FB acceleration enabled. This generally works
> fine for me.
> 
>  This isn't generally too much of a problem because 2.4.x is so
> stable
> I don't have to reboot for weeks!

You can reboot any number of times you want. Just do not unplug
powercord from computer...
 
>  I'm willing to try out some patches if that would be useful.

Problem is that I really do not have any idea what's wrong - as
after any change I do to driver, I cannot know for sure whether
after boot it works because of I worked around some problem, or
because of hardware powered up in `correct' state...
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
