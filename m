Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbVEaVH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVEaVH4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 17:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbVEaVH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 17:07:56 -0400
Received: from alog0010.analogic.com ([208.224.220.25]:45532 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261495AbVEaVHh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 17:07:37 -0400
Date: Tue, 31 May 2005 17:06:28 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Lee Revell <rlrevell@joe-job.com>
cc: Steve Finney <saf76@earthlink.net>, Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Human tIming perception (was: RT patch)
In-Reply-To: <1117569835.23283.24.camel@mindpipe>
Message-ID: <Pine.LNX.4.61.0505311656080.1233@chaos.analogic.com>
References: <10471395.1117558743885.JavaMail.root@wamui-milano.atl.sa.earthlink.net>
 <1117569835.23283.24.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 May 2005, Lee Revell wrote:

> On Tue, 2005-05-31 at 12:59 -0400, Steve Finney wrote:
>> It takes (IIRC) about a 10 ms or
>> so difference in the sounded sequence
>> for someone to be able to report that there's been a change, but
>> a cnange in the timing of the person's finger movements occurs
>> (_immediately_) at perturbations smaller than 10 ms. That is, there
>> appears to be some dissociation  between conscious perception and
>> perceptual/motor behavior.
>
> Any decent guitar player who has used their computer as an effects unit
> could tell you this.  I can easily perceive the difference between 1.3
> and 2.6, and 2.6 and 5ms latencies.  And there's at least one person
> (also a guitarist, who I have added to the cc:) who swears he cam
> perceive the difference between 0.6 and 1.3ms.  Soundcard ADCs typically
> add 1.5ms latency in each direction, so the actual floor seems to be
> around 3-5ms.
>
> Lee
>

Well MIDI runs at 31,250 bits/second or 3,906 bytes per second.
After much research by Dave Smith in the early 80s, the MIDI
spec was published in 1983. The data-rate was based upon not
being able to hear the difference in the simultaneity of a
6-note chord (a triad with both hands on the piano). That
equates to 1/3906 * 6 = 0.00154 seconds. (1.54 ms).

Note that because only one note start or stop can sent at a
time, this information was essential for sending and receiving
chords.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
