Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262660AbTCIW4x>; Sun, 9 Mar 2003 17:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262661AbTCIW4x>; Sun, 9 Mar 2003 17:56:53 -0500
Received: from air-2.osdl.org ([65.172.181.6]:44202 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262660AbTCIW4w>;
	Sun, 9 Mar 2003 17:56:52 -0500
Message-ID: <35152.4.64.238.61.1047251250.squirrel@www.osdl.org>
Date: Sun, 9 Mar 2003 15:07:30 -0800 (PST)
Subject: Re: Reserving physical memory at boot time
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <hpa@zytor.com>
In-Reply-To: <3E6BAD57.803@zytor.com>
References: <Pine.LNX.3.95.1021204115837.29419B-100000@chaos.analogic.com>
        <Pine.LNX.4.33L2.0212040905230.8842-100000@dragon.pdx.osdl.net>
        <b442s0$pau$1@cesium.transmeta.com>
        <32981.4.64.238.61.1046844111.squirrel@www.osdl.org>
        <b453mj$qpi$1@cesium.transmeta.com>
        <20030306212607.GA173@elf.ucw.cz>
        <3E67D89B.1010308@zytor.com>
        <20030307231954.GB164@elf.ucw.cz>
        <3E6BAD57.803@zytor.com>
X-Priority: 3
Importance: Normal
Cc: <pavel@ucw.cz>, <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Pavel Machek wrote:
>>
>> Okay; which mem= options you want killed?
>>
>
> Anything that doesn't match the regexp (in Perl syntax):
>
> /^mem=(0[0-7]*|[1-9][0-9]*|0x[0-9a-f]+)[kmg]$/i
>
>> What about this?
>
> Looks good to me.

Thanks, Pavel.  You beat me to it.

~Randy



