Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266320AbSKLIpe>; Tue, 12 Nov 2002 03:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266323AbSKLIpd>; Tue, 12 Nov 2002 03:45:33 -0500
Received: from denise.shiny.it ([194.20.232.1]:43456 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S266320AbSKLIpc>;
	Tue, 12 Nov 2002 03:45:32 -0500
Message-ID: <XFMail.20021112095219.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3DD046BD.799F36D4@digeo.com>
Date: Tue, 12 Nov 2002 09:52:19 +0100 (CET)
From: Giuliano Pochini <pochini@shiny.it>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.47{-mm1} with contest
Cc: Con Kolivas <conman@kolivas.net>, Andrew Morton <akpm@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 12-Nov-2002 Andrew Morton wrote:
> Con Kolivas wrote:
>>
>> io_load:
>> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
>> 2.4.18 [3]              474.1   15      36      10      6.64
>> 2.4.19 [3]              492.6   14      38      10      6.90
>> 2.5.46 [1]              600.5   13      48      12      8.41
>> 2.5.46-mm1 [5]          134.3   58      6       8       1.88
>> 2.5.47 [3]              165.9   46      9       9       2.32
>> 2.5.47-mm1 [5]          126.3   61      5       8       1.77
>>
>
> We've increased the kernel build speed by 3.6x while decreasing the
> speed at which writes are retired by 5.3x.

Did the elevator change between .46 and .47 ?


Bye.


