Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130793AbRC0IlP>; Tue, 27 Mar 2001 03:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130902AbRC0IlF>; Tue, 27 Mar 2001 03:41:05 -0500
Received: from mail.n-online.net ([195.30.220.100]:21776 "HELO
	mohawk.n-online.net") by vger.kernel.org with SMTP
	id <S130793AbRC0Ik6>; Tue, 27 Mar 2001 03:40:58 -0500
Date: Tue, 27 Mar 2001 10:40:10 +0200
From: Thomas Foerster <puckwork@madz.net>
To: linux-kernel@vger.kernel.org
Subject: Re: URGENT : System hands on "Freeing unused kernel memory: "
X-Mailer: Thomas Foerster's registered AK-Mail 3.1 publicbeta2a [ger]
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010327084101Z130793-406+4326@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On 03.27 Thomas Foerster wrote:
>>
>> But suddenly the box was offline. One technical assistant from our ISP tried
>> to reboot
>> our server (he couldn't tell me if there had been any messages on the screen),
>> but the
>> system always hangs on
>>
>> Freeing unused kernel memory: xxk freed
>>

> Try booting with init=/bin/bash, it looks like kernel gets a bad /sbin/init,
> and gets stuck. Perhaps the shutdown damaged init, it starts to run and get
> hung.

That didn't fix the problem :(

When i run "diff" on a new and the "old" init, i get no diffs ...

Must be something other :(

Thomas

