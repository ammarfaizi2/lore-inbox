Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290279AbSAOUoU>; Tue, 15 Jan 2002 15:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290283AbSAOUoE>; Tue, 15 Jan 2002 15:44:04 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:16111 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S290280AbSAOUnZ>; Tue, 15 Jan 2002 15:43:25 -0500
Message-ID: <3C449426.6000300@us.ibm.com>
Date: Tue, 15 Jan 2002 12:42:14 -0800
From: "David C. Hansen" <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020114
X-Accept-Language: en-us
MIME-Version: 1.0
To: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>,
        Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] cs46xx: sound distortion after hours of use
In-Reply-To: <200201151224.g0FCO8E06163@Port.imtp.ilyichevsk.odessa.ua> <20020115152000.GD13196@arthur.ubicom.tudelft.nl> <3C4482A2.8040903@us.ibm.com> <20020115153439.A413@davetop.uacdd.wvu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >Erik Mouw wrote:
 >I have the same problem, but very rarely.  I, too, use the
 >rmmod/modprobe technique to fix it.  Have either of you found a way to
 >excite the problem without waiting hours for it to happen?
 >

dshepard@wvu.edu wrote:
 > Open and close XMMS a couple of times, while listening to mp3s. This
 > almost always does it for me. I reported this problem many, many
 > months ago, but was told I needed to contact the driver maintainer. I
 > did this and received no reply. I wish you better luck! Using here:
 > IBM Thinkpad A20m.
 >

Hmmm.  I've tried doing this: while true; do cat /proc/apm; done > /dev/null
I then open and close XMMS a few times and plug/unplug my AC adapter
trying to get something to happen.  I haven't had any luck.  The
frustrating part is that I've had the problem before.  I just can't get
it to do it now.
BTW, I have a Thinkpad T21.  Do any of you have a non-IBM notebook?


