Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263814AbTCUUof>; Fri, 21 Mar 2003 15:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263815AbTCUSxt>; Fri, 21 Mar 2003 13:53:49 -0500
Received: from freeside.toyota.com ([63.87.74.7]:34002 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S263814AbTCUSws>; Fri, 21 Mar 2003 13:52:48 -0500
Message-ID: <3E7B6185.1050302@tmsusa.com>
Date: Fri, 21 Mar 2003 11:01:25 -0800
From: jjs <jjs@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Bill Davidsen <davidsen@tmr.com>, root@oddball.prodigy.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.5.64] X unlock doesn't work
References: <Pine.LNX.4.44.0303211040490.5604-100000@oddball.prodigy.com> <20030321082705.23e3d70c.rddunlap@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:

>On Fri, 21 Mar 2003 11:20:24 -0500 (EST) root <root@oddball.prodigy.com> wrote:
>
>| Now there's a new one... I just noticed that in my 2.5.64 kernel, when my 
>| screensaver comes up and asks for a password to unlock, no matter what 
>| password I give it is rejected. With 2.5.59 passwords work for the user 
>| logged in.
>| 
>| Redhat 7.3, GNOME.
>| 
>| I just noticed because this is the first time since 2.5.64 came out that I 
>| did anything from console, since it's a mail machine, stats collector, 
>| etc.
>| 
>| I'll try 2.5.65 next week when I have more time.
>| -- 
>
>I've had this problem for several weeks now, but I had (have) no idea
>where the problem is.
>

Just a me too - Red Hat 8.0, gnome -

xscreensaver unlock stopped working somewhere
in the 2.5.6x series - I figured it must be some signal
related issue -

Joe

