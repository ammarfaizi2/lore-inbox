Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270774AbRHNT7d>; Tue, 14 Aug 2001 15:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270777AbRHNT7Z>; Tue, 14 Aug 2001 15:59:25 -0400
Received: from mta1n.bluewin.ch ([195.186.1.210]:28296 "EHLO mta1n.bluewin.ch")
	by vger.kernel.org with ESMTP id <S270774AbRHNT7K>;
	Tue, 14 Aug 2001 15:59:10 -0400
Message-ID: <3B790EE10002866A@mta1n.bluewin.ch> (added by postmaster@bluewin.ch)
From: "Per Jessen" <per@computer.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "PinkFreud" <pf-kernel@mirkwood.net>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Date: Tue, 14 Aug 2001 22:07:50 +0200
Reply-To: "Per Jessen" <per@computer.org>
X-Mailer: PMMail 98 Professional (2.01.1600) For Windows 95 (4.0.1212)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: Are we going too fast?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2001 12:32:31 -0400 (EDT), PinkFreud wrote:

>> > The latest stable version of the Linux kernel is: 2.4.8 2001-08-11 04:13 
>> > UTC Changelog 
><snip>
>> 
>> Kernel.org certainly should list the 2.2 status (hey I maintain it I'm
>> allowed to be biased). Its unfortunate it many ways that people are still so
>> programmed to the "latest version" obsession of the proprietary world some
>> times. For most people 2.4 is the right choice but for absolute stability
>> why change 8)
>
>I think that's a bit unfair.  Rather, I suspect people see the word 'stable',
>and assume, for some unknown reason, that the kernel is stable.  *AHEM*
>
>Seriously, though - even distributions are including 2.4 kernels now.  RedHat,
>Mandrake, Slackware ... Should the latest versions of these distributions be
>considered unstable as well?

SuSE started shipping 7.1 with a 2.4.0 kernel (optional). I think I installed
it on a development workstation just about the time when 2.4.2 was released.

For what we do (www.enidan.com), I tend to be more conservative, so we were
using 2.0.36 for quite some time, until we decided to move entirely to 2.2.12.
Our 16CPU cluster is up at 2.4.8 - trying to break things :-) -  but for things 
that people depend on, it's 2.2.19. Some workstations are at 2.4.x - depends.

/Per


regards,
Per Jessen, Zurich
http://www.enidan.com - home of the J1 serial console.

Windows 2001: "I'm sorry Dave ...  I'm afraid I can't do that."


