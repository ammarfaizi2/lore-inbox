Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265083AbRGALLp>; Sun, 1 Jul 2001 07:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265086AbRGALLg>; Sun, 1 Jul 2001 07:11:36 -0400
Received: from ABordeaux-102-1-1-204.abo.wanadoo.fr ([193.253.253.204]:9477
	"EHLO rayanne.dyndns.org") by vger.kernel.org with ESMTP
	id <S265083AbRGALL0>; Sun, 1 Jul 2001 07:11:26 -0400
Message-ID: <XFMail.20010701130635.petchema@concept-micro.com>
X-Mailer: XFMail 1.4.4 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
In-Reply-To: <3B3B8C47.D1363D6F@bigfoot.com>
Date: Sun, 01 Jul 2001 13:06:35 +0200 (CEST)
Reply-To: petchema@concept-micro.com
Organization: Concept Micro
From: Pierre Etchemaite <petchema@concept-micro.com>
To: Tim Moore <timothymoore@bigfoot.com>
Subject: Re: AMD thunderbird oops
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 28-Jun-2001 Tim Moore wrote:
>> (I wrote)
>> Some ASUS boards (mostly P3B-F) would either freeze or self reboot
>> when using PhotoShop 5. Everything else would run perfectly.
>> 
>> Disabling MMX optimizations in this software would "solve" the
>> problem.  Another solution found on the web (sorry, I don't have
>> the URL at hand) is to add two or three additionnal capacitors on
>> the back of the board, to solve the electric instabilities that
>> cause the reboots.
> 
> This is incorrect information.  Abit BP6 early revs suffered under load
> from a 100uF cap (EC10, between the CPU sockets) that should have been
> 1500uF.  This was compounded by a weak or otherwise inadequate power
> supply.
> 
> Having run literally 7 P3F-Fs and 6 of their P2B-F predecessors, not a
> single one had any problems.  They were the premiere overclocking boards
> of their day.

Don't get me wrong, I like ASUS boards, and BX chipset boards were a
very safe choice at the time, that's why this problem was very
disturbing when I experienced it on 2 or 3 boards (out of more than 100,
but I guess many never ran Photoshop since then).

I digged my archives.

Adobe Knowledgebase article about the problem
(http://www.adobe.com/support/techdocs/2256a.htm) mentions spontaneous
reboots with Dell Optiplex GX1, ASUS P2B-F and ASUS P3B-F.

I could not find anything about the problem on ASUS websites at the
time.

(unofficial) P2B-(L)S fixing is documented here:
http://www.turbotech.ch/articles2000/000815-p2bls_rework-01.html

(unofficial) CUBX fixing (some of those are also affected):
http://members.ams.chello.nl/mgherard/html/photoshop.html

Best regards,
Pierre.
