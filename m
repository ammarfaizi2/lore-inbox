Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292660AbSBUR34>; Thu, 21 Feb 2002 12:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292661AbSBUR3h>; Thu, 21 Feb 2002 12:29:37 -0500
Received: from otter.mbay.net ([206.40.79.2]:7686 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S292660AbSBUR33> convert rfc822-to-8bit;
	Thu, 21 Feb 2002 12:29:29 -0500
From: John Alvord <jalvo@mbay.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Connecting through parallel port
Date: Thu, 21 Feb 2002 09:16:09 -0800
Message-ID: <doaa7uct0kmrejghngak1udfsduuqglo22@4ax.com>
In-Reply-To: <str77ukfcime75ot3akiqb4f60d6t0urc6@4ax.com> <Pine.LNX.3.96.1020221080853.28609A-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1020221080853.28609A-100000@gatekeeper.tmr.com>
X-Mailer: Forte Agent 1.8/32.553
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2002 08:16:32 -0500 (EST), Bill Davidsen
<davidsen@tmr.com> wrote:

>On Wed, 20 Feb 2002, John Alvord wrote:
>
>> On Wed, 20 Feb 2002 10:39:36 -0500 (EST), Bill Davidsen
>> <davidsen@tmr.com> wrote:
>
>> >There was a protocol called PLIP which did just what you want. I've used
>> >it many times for laptop install (Patrick even fixed it in Slackware at my
>> >request).
>> >
>> >Unfortunately, while the feature is still in recent 2.[45] kernels, it
>> >appears to be broken. The last laptop I installed needed a network card to
>> >get working.
>
>> This was interesting when NIC (network interface cards) cost $100.
>> Nowadays, they are a lot less costly and interest in the PLIP solution
>> has evaporated.
>
>Unless cards now come with their own slot, this is still very useful. A
>system without parallel is very unusual, while one without network is far
>more common, and one without a place to even add a network is not that
>hard to find. While a home user with only a few systems which he can
>configure at will has no trouble adding a NIC, business use in many places
>doesn't work that way, and honestly I have a hard time telling someone to
>buy NICs, cables, a hub, etc, when a $7 cable will work between systems
>with a functional PL/IP kernel.
>
>Considering the low use things supported in the kernel, I see no reason to
>think PL/IP is less so. Not a lot of TokenRing out there these days, even
>in an IBM shop;-)

I guess the only remaining problem is finding someone to support the
code as Linux winds its way onward through the years. Or someone
paying to do that work.

john
