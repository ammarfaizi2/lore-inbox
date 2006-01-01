Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbWAAPVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbWAAPVR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 10:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbWAAPVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 10:21:17 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:9655 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750847AbWAAPVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 10:21:17 -0500
Date: Sun, 1 Jan 2006 16:21:07 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Bradley Reed <bradreed1@gmail.com>
cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: MPlayer broken under 2.6.15-rc7-rt1?
In-Reply-To: <20060101115121.034e6bb7@galactus.example.org>
Message-ID: <Pine.LNX.4.61.0601011619400.11226@yvahk01.tjqt.qr>
References: <20051231202933.4f48acab@galactus.example.org>
 <1136106861.17830.6.camel@laptopd505.fenrus.org> <20060101115121.034e6bb7@galactus.example.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> you know, you could have done a little bit more effort and reproduced
>> this without the binary crud... it's not that hard you know and it
>> shows that you actually care about the problem enough that you want
>> to make it worthwhile for people to look into it.
>
>And you could have saved the time and effort of replying, as you had
>nothing useful to say. Why do you expect kernel users (non-developers) 
>to jump through hoops and cripple their systems in order to provide bug
>reports? Exactly how could I have tested MPLayer realistically without
>Xv support? It isn't that easy to swap video cards in a laptop.

Well, -vo is teh option with which you can choose anything, down to aa.

>Yes, I was very fortunate in that someone else with a non-tainted
>kernel noticed a similar bug with /dev/rtc, and even more fortunate

Oh did not notice *I* actually ran a tainted one *too* :p
but not touching X (despite having loaded a prop module) at all is 
sometimes enough to "untaint" a bug report ;)


Jan Engelhardt
-- 
