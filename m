Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751711AbWJANxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbWJANxf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 09:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751728AbWJANxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 09:53:35 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:30412 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751688AbWJANxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 09:53:35 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <451FC7DC.7070909@s5r6.in-berlin.de>
Date: Sun, 01 Oct 2006 15:51:24 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Miguel Ojeda <maxextreme@gmail.com>
CC: akpm@osdl.org, Randy Dunlap <rdunlap@xenotime.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18 V7] drivers: add lcd display support
References: <20060930232445.59e8adf6.maxextreme@gmail.com> <653402b90610010553p23819d2bsd7a07fabaee7ecf3@mail.gmail.com>
In-Reply-To: <653402b90610010553p23819d2bsd7a07fabaee7ecf3@mail.gmail.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Ojeda wrote:
> On 10/1/06, Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
...
>> It is as common as it is wrong.
...
>> "LCD" and "LC display" are correct.
>>
> 
> Sure it is wrong, the point is what is the best to understading. "LCD
> display" seems better to me than just "LC display".
...
> tristate "ks0108 LCD controller"
> tristate "cfag12864b LCD"
> 
> That is the correct spelling, however, does it look good?
> 
> (I really don't know what is the best way to write it in english, I'm
> spanish and here it is more common to say "LCD display").

"LCD display" is wrong and, excuse me, dumb in *all* languages. The fact
that it is common doesn't make it a smart thing to say or write. :-)

If you find "LCD" or "LC display" ugly to look at or hard to understand
(IMO it is not hard to understand if it appears in a computer technology
related context), you could write "liquid crystal display". I suppose
you could also just write "cfag12864b display".

I am not sure which looks prettiest. But I know that "LCD display" looks
really bad to everybody who knows what the D stands for. :-)
-- 
Stefan Richter
-=====-=-==- =-=- ----=
http://arcgraph.de/sr/
