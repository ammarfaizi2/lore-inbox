Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281217AbRKRIgG>; Sun, 18 Nov 2001 03:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281239AbRKRIfz>; Sun, 18 Nov 2001 03:35:55 -0500
Received: from smtp01.iprimus.net.au ([203.134.64.99]:6158 "EHLO
	smtp01.iprimus.net.au") by vger.kernel.org with ESMTP
	id <S281217AbRKRIfg>; Sun, 18 Nov 2001 03:35:36 -0500
Content-Type: text/plain; charset=US-ASCII
From: Paul <krushka@iprimus.com.au>
Reply-To: krushka@iprimus.com.au
To: linux-kernel@vger.kernel.org
Subject: Compact Flash and IDE interface
Date: Sun, 18 Nov 2001 18:41:09 +1000
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01111818410900.02037@paul.home.com.au>
Content-Transfer-Encoding: 7BIT
X-OriginalArrivalTime: 18 Nov 2001 08:35:22.0341 (UTC) FILETIME=[F65E4950:01C1700B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I hope I'm sending this to the right list, sorry if it's not :)

With compact flash cards connected via IDE what is the "normal" expected 
transfer rates?  I have a Sandisk (32 and 128MB) and I only get around 
2MB/sec (read test using hdparm) when all the docs from sandisk suggest 
around 16MB/sec.  They haven't returned my emails so I suspect their specs 
are a little misleading...they quote around 16MB/sec read transfer rates.

What sort of read rates should I be expecting?

Thanks

Paul
