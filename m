Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261334AbTCOQ5z>; Sat, 15 Mar 2003 11:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261476AbTCOQ5z>; Sat, 15 Mar 2003 11:57:55 -0500
Received: from air-2.osdl.org ([65.172.181.6]:48045 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261334AbTCOQ5y>;
	Sat, 15 Mar 2003 11:57:54 -0500
Message-ID: <33707.4.64.238.61.1047748124.squirrel@www.osdl.org>
Date: Sat, 15 Mar 2003 09:08:44 -0800 (PST)
Subject: Re: [PATCH] update filesystems config. menu
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <azarah@gentoo.org>
In-Reply-To: <1047720287.3505.146.camel@workshop.saharact.lan>
References: <200303150920.h2F9KGm16328@mako.theneteffect.com>
        <1047720287.3505.146.camel@workshop.saharact.lan>
X-Priority: 3
Importance: Normal
Cc: <mitch@theneteffect.com>, <davej@codemonkey.org.uk>,
       <Randy.Dunlap@mako.theneteffect.com>, <randy.dunlap@verizon.net>,
       <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, 2003-03-15 at 11:20, Mitch Adair wrote:
>
>> Anyway, I have seen instances where root got mounted ext2 instead of ext3
>> (faulty initrd or whatever it was) - just wondered if the help should
>> really push people to unreservedly say Y to ext2 if their root is really
>> ext3...
>>
>
> Should be safest for most people .. those that have experience will anyhow
> know to only compile in ext3 support, and ext2 as module (if you ever fsck
> floppy/whatever as ext2).

Hi Martin,

I'm having trouble decoding...
What is it that "should be safest for most people"?
Are you suggesting any changes here?

And some of us don't use fs modules, just build what we need into the
kernel.  Do you know of any problems with doing this (related to
ext2/ext3 for example)?

Thanks,
~Randy



