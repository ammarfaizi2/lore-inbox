Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261567AbSIXF0d>; Tue, 24 Sep 2002 01:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261570AbSIXF0c>; Tue, 24 Sep 2002 01:26:32 -0400
Received: from mail.gmx.de ([213.165.64.20]:32883 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261567AbSIXF0c>;
	Tue, 24 Sep 2002 01:26:32 -0400
Message-Id: <5.1.0.14.2.20020924071843.00b9cbc0@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 24 Sep 2002 07:28:58 +0200
To: linux-kernel@vger.kernel.org
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [BENCHMARK] Statistical representation of IO load results
  with contest
In-Reply-To: <1032823598.3d8fa32e92e94@kolivas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:26 AM 9/24/2002 +1000, Con Kolivas wrote:
>Thank you all who responded with suggestions on how to get useful data out of
>the IO load module from contest. These are _new_ results with a
>sync,swapoff,swapon before conducting just the IO load. I have digested 
>all your
>suggestions and come up with the following:
>
>n=5 for number of samples
>
>Kernel          Mean    CI(95%)
>2.5.38          411     344-477
>2.5.39-gcc32    371     224-519
>2.5.38-mm2      95      84-105

/me wonders what other benchmarks numbers will look like.  (db stuff should 
rock?)

         -Mike

