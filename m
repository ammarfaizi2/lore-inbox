Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132718AbRDQPXK>; Tue, 17 Apr 2001 11:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132724AbRDQPWx>; Tue, 17 Apr 2001 11:22:53 -0400
Received: from mail.reutershealth.com ([204.243.9.36]:31919 "EHLO
	mail.reutershealth.com") by vger.kernel.org with ESMTP
	id <S132717AbRDQPWM>; Tue, 17 Apr 2001 11:22:12 -0400
Message-ID: <3ADC5FD9.9050905@reutershealth.com>
Date: Tue, 17 Apr 2001 11:23:05 -0400
From: John Cowan <jcowan@reutershealth.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; 0.8) Gecko/20010215
X-Accept-Language: en
MIME-Version: 1.0
CC: John Cowan <cowan@mercury.ccil.org>, james rich <james.rich@m.cc.utah.edu>,
        linux-kernel@vger.kernel.org
Subject: CMLConfigurator skins (was: CML2 1.1.3 is available)
In-Reply-To: <20010416205556.A22960@thyrsus.com> <E14pTOH-0007ex-00@mercury.ccil.org> <20010417103856.A27762@thyrsus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric S. Raymond wrote:

 > Other possibility: support only the 16 EGA colors by name.

Excellent idea!

 > But if I do that,
 > some of the X colors are just *wrong* on standard gray background
 > (cyan is a good example).

So let the user set the background color too.  I find gray backgrounds
a mortal pain (the "standard" 75% gray of browsers, e.g., is a bad
compromise between pictures, which want 50% gray, and text, which wants
100% gray = white).

When I write HTML, my only concession to non-Strictness is a
"bgcolor='white'" attribute in every <body> start-tag.

 > There's no way to get this right.

There's no way to get it Good and Right for all, without more work
than you are willing to put in, following the hacker *mabla*-tradition
of basically ignoring UI/HF issues.

But it is still possible to make it Bad and Right, using such a hack as
described above.  What you have now is Good and Right for some and Bad
and Wrong for others, and the number of "others" can only grow --- no
matter how much you dink the colors in Brownian motion, responding to
random electromagnetic forces from randoms.

 > So I choose to get it wrong in a simple
 > way rather than a complex, costly way.

Don't say you weren't warned, nag, nag, nag, ...

My strategy here is to make sufficient fuss that you are motivated to
get off your duff to shut me up. :-) Better me than some irate
newbie who decides that configuring kernels "can make you blind, man".

And whilst you are implementing this, make sure a range of font sizes
is allowed in the X version.  My middle-aged eyes are more and more
happy with the "huge" setting in the xterm control-rightbutton menu,
especially on SuperVGA screen sizes.

-- 
There is / one art             || John Cowan <jcowan@reutershealth.com>
no more / no less              || http://www.reutershealth.com
to do / all things             || http://www.ccil.org/~cowan
with art- / lessness           \\ -- Piet Hein

