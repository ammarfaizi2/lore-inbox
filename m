Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267458AbRG2B5M>; Sat, 28 Jul 2001 21:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267494AbRG2B5C>; Sat, 28 Jul 2001 21:57:02 -0400
Received: from weta.f00f.org ([203.167.249.89]:9862 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S267458AbRG2B4w>;
	Sat, 28 Jul 2001 21:56:52 -0400
Date: Sun, 29 Jul 2001 13:57:28 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Steve Snyder <swsnyder@home.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What does "Neighbour table overflow" message indicate?
Message-ID: <20010729135728.B3282@weta.f00f.org>
In-Reply-To: <01072820231401.01125@mercury.snydernet.lan> <20010729133848.A3254@weta.f00f.org> <01072820534802.01125@mercury.snydernet.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01072820534802.01125@mercury.snydernet.lan>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sat, Jul 28, 2001 at 08:53:48PM -0500, Steve Snyder wrote:

    No, and no errors are shown for it either:

    # ifconfig lo
    lo        Link encap:Local Loopback
              inet addr:127.0.0.1  Mask:255.0.0.0
              UP LOOPBACK RUNNING  MTU:16436  Metric:1
              RX packets:196907 errors:0 dropped:0 overruns:0 frame:0
              TX packets:196907 errors:0 dropped:0 overruns:0 carrier:0
              collisions:0 txqueuelen:0

    All *seems* well.  Just that 30-second period of messages and then
    silence.


What is the machine doing?  What kind of network is it attached to and
with how many hosts on it?



  --cw
