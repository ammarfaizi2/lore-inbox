Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290491AbSBKVSL>; Mon, 11 Feb 2002 16:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290421AbSBKVSB>; Mon, 11 Feb 2002 16:18:01 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:39122 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S290470AbSBKVR4>;
	Mon, 11 Feb 2002 16:17:56 -0500
Date: Mon, 11 Feb 2002 21:17:51 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Bill Davidsen <davidsen@tmr.com>,
        Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: How to check the kernel compile options ?
Message-ID: <122882221.1013462271@[195.224.237.69]>
In-Reply-To: <Pine.LNX.3.96.1020211140359.642A-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1020211140359.642A-100000@gatekeeper.tmr.com>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > The problem is that it make the kernel image larger, which lives in
>> > /boot on many systems. Putting it in a module directory, even if not a
>> > module, would be a better place for creative boot methods, of which
>> > there are many.
>>
>> You don't seem to be clear on the concept of 'option'.
>
> Did I miss discussion of an option to put it somewhere other than as part
> of the kernel? Sorry, I missed that.

This option would be selected by typing 'n' into your
favourite kernel configuration utility.

--
Alex Bligh
