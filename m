Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbUCFDlX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 22:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbUCFDlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 22:41:23 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:39384 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261578AbUCFDlW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 22:41:22 -0500
Message-ID: <4049485B.3070104@cyberone.com.au>
Date: Sat, 06 Mar 2004 14:41:15 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Markus_H=E4stbacka?= <midian@ihme.org>
CC: Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: nicksched v30
References: <4048204E.8000807@cyberone.com.au> <1078488995.13256.1.camel@midux>
In-Reply-To: <1078488995.13256.1.camel@midux>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Markus Hästbacka wrote:

>On Fri, 2004-03-05 at 08:38, Nick Piggin wrote:
>
>>http://www.kerneltrap.org/~npiggin/v30.gz
>>
>>Applies to kernel 2.6.4-rc1-mm2.
>>Run X at about nice -10 or -15.
>>Please report interactivity problems with the default scheduler
>>before using this one etc etc.
>>
>>Thanks
>>
>Same patch for 2.6.4-rc2? mm breaks up a few things for me :(
>
>

Unfortunately not. The scheduler in -mm is different enough
that porting isn't straightfoward.

What does mm break for you?

