Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273815AbRIXILO>; Mon, 24 Sep 2001 04:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273820AbRIXILE>; Mon, 24 Sep 2001 04:11:04 -0400
Received: from lego.zianet.com ([204.134.124.54]:38406 "EHLO lego.zianet.com")
	by vger.kernel.org with ESMTP id <S273815AbRIXIKw>;
	Mon, 24 Sep 2001 04:10:52 -0400
Message-ID: <3BAEE975.10602@zianet.com>
Date: Mon, 24 Sep 2001 02:06:13 -0600
From: Steven Spence <kwijibo@zianet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4+) Gecko/20010921
X-Accept-Language: en-us
MIME-Version: 1.0
To: Matthew Koch <mkoch@synitech.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: EMU10k1 Driver
In-Reply-To: <32832.65.11.238.48.1001284227.squirrel@mail.synitech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Koch wrote:

>I'm experiencing issues with the EMU10k1 driver in kernel's 2.4.9 and
>2.4.10.  I have an SB Live! X-Gamer card (not 5.1).  It worked perfectly
>under 2.4.7.  The mixer is recognized as a SigmaTel card, which is obviously
>mistaken.  In addition to that, sound quality is poor and the mixer is not
>displaying all the options, specifically digital1 and digital2, the front
>and rear outputs.  I'm writing here because the code itself has no contacts
>listed as far as I found.  Are there any known fixes to this?  Thank you.
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
Alot has changed with respect to DSP routing and such since the 2.4.7 
version.

Try www.opensource.creative.com or emu10k1-devel@opensource.creative.com
for more info on driver devel.

Steve

