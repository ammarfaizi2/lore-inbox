Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318361AbSHEKHl>; Mon, 5 Aug 2002 06:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317849AbSHEKHl>; Mon, 5 Aug 2002 06:07:41 -0400
Received: from [217.167.51.129] ([217.167.51.129]:10207 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S318361AbSHEKHk>;
	Mon, 5 Aug 2002 06:07:40 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, <pil@mailnet.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: HFS-Bug in 2.4.19
Date: Mon, 5 Aug 2002 12:11:23 +0200
Message-Id: <20020805101123.6911@192.168.4.1>
In-Reply-To: <1028545408.17775.26.camel@irongate.swansea.linux.org.uk>
References: <1028545408.17775.26.camel@irongate.swansea.linux.org.uk>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> here is my 4th report since about 2.4.8:
>> 
>> You can reproduce the bug in a few steps if you have a kernel with
>> modules support for hfs.
>
>HFS is not maintained. It will probably go away for 2.6 unless someone
>becomes its maintainer and fixes it

I noticed Al finally burned me on this as he did some locking fixes
to HFS in 2.5. I'm pretty sure more is needed, and I still have some
plans to fix some of it, in both 2.4 and 2.5, it's just that so far,
I've always found more important things to do of my linux dedicated
time ;)

Ben.


