Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264039AbRF1Tea>; Thu, 28 Jun 2001 15:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264103AbRF1TeV>; Thu, 28 Jun 2001 15:34:21 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:52617 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S264039AbRF1TeJ>;
	Thu, 28 Jun 2001 15:34:09 -0400
Message-ID: <3B3B86D5.EBFC5A7E@mandrakesoft.com>
Date: Thu, 28 Jun 2001 15:34:45 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Patrick Dreker <patrick@dreker.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Woodhouse <dwmw2@infradead.org>, jffs-dev@axis.com,
        linux-kernel@vger.kernel.org
Subject: Re: Cosmetic JFFS patch.
In-Reply-To: <Pine.LNX.4.33.0106281218550.15199-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Especially as "dmesg" will output even the debugging messages
> that do not actually end up being printed on the screen unless explicitly
> asked for.

Nifty, I did not know that.  Makes all kinds of sense, though.  Silly
me...


> I'd also like to acknowledge the fact that at bootup it's usually very
> nice to see "what was the last message it printed before it hung", and
> that there's a fair reason for drivers to print out a single line of "I
> just registered myself" for that reason. If that line happens to contain a
> version string, all the better.

Excellent.

	Jeff


-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
