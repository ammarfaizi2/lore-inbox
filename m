Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264110AbTKTXfp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 18:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264112AbTKTXfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 18:35:45 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:28335 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264110AbTKTXfk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 18:35:40 -0500
Message-ID: <3FBD4F6E.3030906@cyberone.com.au>
Date: Fri, 21 Nov 2003 10:34:06 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: =?ISO-8859-15?Q?Markus_H=E4stbacka?= <midian@ihme.org>
CC: Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: Nick's scheduler v19a
References: <3FB62608.4010708@cyberone.com.au> <1069361130.13479.12.camel@midux>
In-Reply-To: <1069361130.13479.12.camel@midux>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Markus Hästbacka wrote:

>Hi nick! here's some feedback.
>This one day last week, I thougt I could test your scheduler patch.
>I noticed something really good with it. My X had really fast startup.
>everything worked really fast. Even games worked much better than any in
>kernel before (I've tested all from 2.5.74).
>
>So I hope you'll port this patch for test10> if this one wont patch
>clearly.
>

Hi Markus,
Thanks for testing. That sounds quite remarkable, is it possible that
some other change has made the difference? What kernel version did
you patch against, and did you try that same kernel and .config without
my patch? Anyway, I'm glad you're having good results.

Yes, this one will probably apply to test10 should it ever apper. If not
I will port it.

Nick


