Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289536AbSAJQpQ>; Thu, 10 Jan 2002 11:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289539AbSAJQpG>; Thu, 10 Jan 2002 11:45:06 -0500
Received: from svr3.applink.net ([206.50.88.3]:10254 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S289536AbSAJQpD>;
	Thu, 10 Jan 2002 11:45:03 -0500
Message-Id: <200201101644.g0AGibSr029326@svr3.applink.net>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: Andrew Morton <akpm@zip.com.au>, Rob Landley <landley@trommello.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Thu, 10 Jan 2002 10:40:46 -0600
X-Mailer: KMail [version 1.3.2]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <E16OM59-0001hQ-00@the-village.bc.nu> <200201091932.g09JW9A27178@snark.thyrsus.com> <3C3CA091.B28D5DFC@zip.com.au>
In-Reply-To: <3C3CA091.B28D5DFC@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 January 2002 13:57, Andrew Morton wrote:
[snip]
>
> Without LL, Linux cannot reasonably be used for professional audio
> work that involves real time FX or real time synthesis. The default
> kernel has worst-case latencies noticeably worse than Windows, and
> most people are reluctant to use that system already, not just because
> of instability but latencies also. Its not a matter of it being "a bit
> of a problem" - the 100msec worst case latencies visible in the
> standard kernel make it totally implausible that you would ever deploy
> Linux in a situation where RT FX/synthesis were going to happen.
>
> By contrast, if we get LL in place, then we can potentially use Linux
> in "black box"/"embedded" systems designed specifically for audio
> users; all the flexibility of Linux, but if they choose to ignore most
> of that, they'll still have a black rack-mounted box capable of doing
> everything (more mostly everything) currently done by dedicated
> hardware. As general purpose CPU performance continues to increase,
> this becomes more and more overwhelmingly obvious as the way forward
> for audio processing.
>

I keep on seeing these "Blackbox" apps like Tivo using Linux but the
fact remains the average folks cannot get any reasonable kind of A/V
performance and support under Linux.    That's what we need.

Needing to save money and get some fast cash (I'm unemployed), 
yesterday, I swapped out my dual P-III motherboard in my BeOS box
for a Via C-III (700MHz) based system.    And I got my first real hiccups
while using the OS when I was playing MP3s and _launching_ the TV
program _full screen_(640x480 on 640x480 virtual desktop window).

Obviously, when this stuff is done right, more CPU power can only help,
but it still has to be done right.  As I am sure that you know, BeOS claims
average latency of 250 microseconds.


-- 
timothy.covell@ashavan.org.
