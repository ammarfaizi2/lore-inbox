Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274699AbRITXi7>; Thu, 20 Sep 2001 19:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274701AbRITXik>; Thu, 20 Sep 2001 19:38:40 -0400
Received: from [216.151.155.121] ([216.151.155.121]:37391 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S274699AbRITXia>; Thu, 20 Sep 2001 19:38:30 -0400
To: "Garst R. Reese" <reese@isn.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: VM or Netscape problem?
In-Reply-To: <3BAA74B4.63243DDF@isn.net>
From: Doug McNaught <doug@wireboard.com>
Date: 20 Sep 2001 19:38:41 -0400
In-Reply-To: "Garst R. Reese"'s message of "Thu, 20 Sep 2001 19:59:00 -0300"
Message-ID: <m3k7ytigam.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Garst R. Reese" <reese@isn.net> writes:

> This could be a long standing bug as it is difficult to reproduce.
> Periodically Netscape(4.75) will tell me that it cannot find anybody,
> including my mail server. This is after it has already been there in the
> same session. Quitting Netscape and restarting fixes the problem. When I
> see this and think to look at free, I find that I am just into swap a
> few Mb. I'm wondering if VM could be kicking out part of Netscape and
> not getting it back (in time). 

I've run into this too, under many kernels.  Netscape 4.x doesn't need 
any kernel help to be buggy as hell.  I don't use it anymore.

With Mozilla where it is, I don't see any reason to run NS4 anymore,
except perhaps for compatibility testing of websites.

>                                I have also had the box lockup switching
> back to X from a text VT and the problems could be related.

Very doubtful.

-Doug
-- 
In a world of steel-eyed death, and men who are fighting to be warm,
Come in, she said, I'll give you shelter from the storm.    -Dylan
