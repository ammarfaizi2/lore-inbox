Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319427AbSIGAFO>; Fri, 6 Sep 2002 20:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319428AbSIGAFN>; Fri, 6 Sep 2002 20:05:13 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40978 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319427AbSIGAFN>; Fri, 6 Sep 2002 20:05:13 -0400
Message-ID: <3D7943BD.8040009@zytor.com>
Date: Fri, 06 Sep 2002 17:09:33 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020703
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: Disabled kernel.org accounts
References: <Pine.LNX.4.44L.0209062105470.1857-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On 6 Sep 2002, H. Peter Anvin wrote:
> 
> 
>>I have disabled several kernel.org accounts due to bouncing email.
>>If you have a kernel.org account and you can no longer log in, please
>>contact me and provide an updated, *working* email.
> 
> 
> Would that have something to do with the fact that master.kernel.org
> is in SPEWS, BLARS and XBL (well, nobody uses XBL of course ...)
> 
> http://spews.org/ask.cgi?S343
> http://www.blars.org/errors/block.html?64.158.222.226
> 

In the case of at least one account, yes.  I just put up the following
blurb to explain why that is, since it's becoming an FAQ:


linux.kernel.org, our mailing list server, keeps getting listed in the
SPEWS RBL due to numerical proximity with an alleged spammer. We have
pointed this out to them on several occations, and they usually fix it
-- but a couple of weeks later we find the same problem. For obvious
reasons, we do not recommend that you use the SPEWS RBL or any site that
derive from their information, including relays.osirusoft.com; see this
page.

Please note that The Kernel Dot Org Organization do not endorse or
support spam in any shape, way or form, and certainly do not recognize
any sort of "right to spam." Spam is at the very least offensive and
more often than not fraudulent, theft of service and invasion of
privacy. We appreciate that it's a hard and thankless job to run after
spammers, and appreciate the services that well-run RBL services provide.


	-hpa

