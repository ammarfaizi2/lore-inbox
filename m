Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312381AbSD2OYs>; Mon, 29 Apr 2002 10:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312393AbSD2OYr>; Mon, 29 Apr 2002 10:24:47 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:20610 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S312381AbSD2OYq>;
	Mon, 29 Apr 2002 10:24:46 -0400
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
Reply-To: conman@kolivas.net
To: linux-kernel@vger.kernel.org
Subject: Combined low latency & performance patches for 2.4.18
Date: Tue, 30 Apr 2002 00:24:43 +1000
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020429142443.A62481333@pc.kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've combined the following patches against 2.4.18:

Scheduler 0(1)
Low Latency
Preemptible
Compressed cache
new IDE subsystem

These are based on fairly recent patches, but not all are the latest.

I've noticed palpable improvements (the feel of using the machine) enabling 
all of these except for the compressed cache but have no data to support my 
feelings. The machine I tried them on was up for 3 weeks with heavy loads and 
proved to be quite stable. I've posted a combined patch at:

http://kernel.kolivas.net

Feel free to test it out and tell me what you think.
Thanks very much to those who put all the effort into each one of these 
patches.

Con Kolivas

P.S. Please CC me as not subscribed to LKML.
