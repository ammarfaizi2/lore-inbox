Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262454AbVDGNF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbVDGNF6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 09:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262455AbVDGNF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 09:05:58 -0400
Received: from alog0663.analogic.com ([208.224.223.200]:57784 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262454AbVDGNFq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 09:05:46 -0400
Date: Thu, 7 Apr 2005 09:03:01 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Humberto Massa <humberto.massa@almg.gov.br>
cc: David Schmitt <david@black.co.at>, debian-kernel@lists.debian.org,
       debian-legal@lists.debian.org, linux-kernel@vger.kernel.org,
       linux-acenic@sunsite.dk
Subject: Re: non-free firmware in kernel modules, aggregation and unclear
 copyright notice.
In-Reply-To: <4255278E.4000303@almg.gov.br>
Message-ID: <Pine.LNX.4.61.0504070855510.29251@chaos.analogic.com>
References: <L0f93D.A.68G.D2OVCB@murphy> <4255278E.4000303@almg.gov.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Apr 2005, Humberto Massa wrote:

> David Schmitt wrote:
>
>>  On Thursday 07 April 2005 09:25, Jes Sorensen wrote:
>>
>>> [snip] I got it from Alteon under a written agreement stating I
>>> could distribute the image under the GPL. Since the firmware is
>>> simply data to Linux, hence keeping it under the GPL should be just
>>> fine.
>>
>>
>>  Then I would like to exercise my right under the GPL to aquire the
>>  source code for the firmware (and the required compilers, starting
>>  with genfw.c which is mentioned in acenic_firmware.h) since - as far
>>  as I know - firmware is coded today in VHDL, C or some assembler and
>>  the days of hexcoding are long gone.
>
> First, there is *NOT* any requirement in the GPL at all that requires
> making compilers available. Otherwise it would not be possible, for
> instance, have a Visual Basic GPL'd application. And yes, it is possible.
>
> Second, up until the present day I have personal experience with
> hardware producers that do not have enough money to buy expensive
> toolchains and used a lot of hand-work to code hardware parameters. So,
> at least for them, hand-hexcoding-days are still going.
>
> HTH,
>
> Massa

Well it doesn't make any difference. If GPL has degenerated to
where one can't upload microcode to a device as part of its
initialization, without having the "source" that generated that
microcode, we are in a lot of hurt. Intel isn't going to give their
designs away.

Last time I checked, GPL was about SOFTware, not FIRMware, and
not MICROcode. If somebody has decided to rename FIRMware to
SOFTware, then they need to complete the task and call it DORKware,
named after themselves.

This whole thread and gotten truly bizarre.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
