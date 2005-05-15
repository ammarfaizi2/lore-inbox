Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbVEOU0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVEOU0V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 16:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVEOU0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 16:26:21 -0400
Received: from alog0072.analogic.com ([208.224.220.87]:55506 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261218AbVEOU0U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 16:26:20 -0400
Date: Sun, 15 May 2005 16:25:51 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Valdis.Kletnieks@vt.edu
cc: Bill Davidsen <davidsen@tmr.com>,
       "Srinivas G." <srinivasg@esntechnologies.co.in>,
       linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: Y2K-like bug to hit Linux computers! - Info of the day 
In-Reply-To: <200505132047.j4DKlcgV025923@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.61.0505151622310.16054@chaos.analogic.com>
References: <4EE0CBA31942E547B99B3D4BFAB348114BED13@mail.esn.co.in>
 <200505131522.32403.vda@ilport.com.ua> <Pine.LNX.4.61.0505130825310.4428@chaos.analogic.com>
 <Pine.LNX.4.61.0505130837390.4781@chaos.analogic.com>           
 <42850FC7.7010603@tmr.com> <200505132047.j4DKlcgV025923@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 May 2005 Valdis.Kletnieks@vt.edu wrote:

> On Fri, 13 May 2005 16:36:23 EDT, Bill Davidsen said:
>>
>>> Mon Jan 18 22:14:07 EST 2038
>>> Fri Dec 13 15:46:09 EST 1901
>>                  ^^^^^ are UTC and GMT that far apart? Leap seconds? WTF?
>
> The heck with leap seconds - why did it warp back to 1901 rather
> than to 1969/1970? ;)
>
Negative time. Will go as far below Unix birthdate as above. That's why
there was a suggestion in the Y2K days of changing time_t to unsigned
and biasing it off the Unix birthdate. But the pedants complained that
Unix files, created before Unix existed, would have the wrong date.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
