Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263821AbTJ1BsV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 20:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbTJ1BsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 20:48:21 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:43741 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263821AbTJ1BsU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 20:48:20 -0500
Message-ID: <3F9DCAE0.1010109@cyberone.com.au>
Date: Tue, 28 Oct 2003 12:48:16 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Nigel Cunningham <ncunningham@clear.net.nz>
CC: cliff white <cliffw@osdl.org>, Michael Frank <mhf@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test8/test9 io scheduler needs tuning?
References: <200310261201.14719.mhf@linuxmail.org> <20031027145531.2eb01017.cliffw@osdl.org> <3F9DAF2C.8010308@cyberone.com.au> <1067305071.1693.14.camel@laptop-linux>
In-Reply-To: <1067305071.1693.14.camel@laptop-linux>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nigel Cunningham wrote:

>I'll try it with my software suspend patch. Under 2.4, I get around 45
>pages per jiffy written when suspending. Under 2.6, I'm currently
>getting 2-4, so any improvement should be obvious!
>

It might speed it up a bit for you. Although maybe you are measuring
with 100 vs 1000 jiffies/s?


