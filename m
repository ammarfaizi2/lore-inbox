Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261752AbSIXRoa>; Tue, 24 Sep 2002 13:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261731AbSIXRni>; Tue, 24 Sep 2002 13:43:38 -0400
Received: from packet.digeo.com ([12.110.80.53]:43434 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261752AbSIXRmX>;
	Tue, 24 Sep 2002 13:42:23 -0400
Message-ID: <3D90A532.4B95C06B@digeo.com>
Date: Tue, 24 Sep 2002 10:47:30 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.38-mm2 dbench $N times
References: <20020924132031.GJ6070@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Sep 2002 17:47:30.0915 (UTC) FILETIME=[74980330:01C263F2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> Taken on 32x/32G NUMA-Q:
> 
> Throughput 67.3949 MB/sec (NB=84.2436 MB/sec  673.949 MBit/sec)  16 procs
> dbench 16  11.72s user 122.21s system 422% cpu 31.733 total
> 

Taken on 2x/0.8G el-scruffo PC:

Throughput 135.02 MB/sec (NB=168.775 MB/sec  1350.2 MBit/sec)
./dbench 16  12.11s user 16.29s system 181% cpu 15.646 total

What's up with that?
