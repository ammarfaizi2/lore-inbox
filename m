Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290797AbSCDBiP>; Sun, 3 Mar 2002 20:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290818AbSCDBiF>; Sun, 3 Mar 2002 20:38:05 -0500
Received: from flrtn-4-m1-42.vnnyca.adelphia.net ([24.55.69.42]:52955 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S290797AbSCDBh4>;
	Sun, 3 Mar 2002 20:37:56 -0500
Message-ID: <3C82CFE0.4050804@tmsusa.com>
Date: Sun, 03 Mar 2002 17:37:36 -0800
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020207
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: latency & real-time-ness.
In-Reply-To: <E16hhLZ-00067I-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>It might be very difficult to fix up the
>>low latency patch for the latest -ac,
>>
>
>You should be able to just dump out the vm part of it - Rik put that into
>rmap anyuway afaik
>
Ah, excellent - good to know, I'll check
that out tonight -

BTW 2.4.19-pre2-ac1 was pretty good for
me - The GUI remained snappy and the
mp3s played smoothly all while running
dbench 128 - The O(1) scheduler and rmap
stuff look like a win -

Joe

