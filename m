Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262807AbTAaWxr>; Fri, 31 Jan 2003 17:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263039AbTAaWxr>; Fri, 31 Jan 2003 17:53:47 -0500
Received: from packet.digeo.com ([12.110.80.53]:16364 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262807AbTAaWxr>;
	Fri, 31 Jan 2003 17:53:47 -0500
Message-ID: <3E3B0030.5580060A@digeo.com>
Date: Fri, 31 Jan 2003 15:01:04 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.51 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.net>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.59-mm7 with contest
References: <200302010930.54538.conman@kolivas.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Jan 2003 23:01:04.0870 (UTC) FILETIME=[A1DF7860:01C2C97C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> 
> ...
> io_load:
> Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
> 2.5.59          3       153     50.3    8       13.7    1.94
> 2.5.59-mm6      2       90      83.3    2       6.7     1.15
> 2.5.59-mm7      5       110     68.2    2       6.4     1.41
> read_load:
> Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
> 2.5.59          3       102     76.5    5       4.9     1.29
> 2.5.59-mm6      3       733     10.8    56      6.3     9.40
> 2.5.59-mm7      4       90      84.4    1       1.3     1.15

The background loads took some punishment.
