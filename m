Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317561AbSFMJUi>; Thu, 13 Jun 2002 05:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317562AbSFMJUh>; Thu, 13 Jun 2002 05:20:37 -0400
Received: from [212.3.242.3] ([212.3.242.3]:59643 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id <S317561AbSFMJUe>;
	Thu, 13 Jun 2002 05:20:34 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: DevilKin <devilkin-lkml@blindguardian.org>
To: linux-kernel@vger.kernel.org
Subject: NM256: Sound playback pointer invalid!
Date: Thu, 13 Jun 2002 11:19:26 +0200
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200206131119.26862.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Since upgrading to 2.4.18 (tested with later kernels too, running 
2.4.19-pre10-ac2 right now) I have the following problem: every time my 
soundchip is activated for the first time, it makes a horrible screetching 
noise. Just plain horrible. After that, playback is perfect.

In the logs i get:

NM256: Sound playback pointer invalid!

I've looked on the net for some info, but I haven't been able to find anything 
that really cures this problem.

Anything else I can try?

Thanks!

DK

-- 
You worry too much about your job.  Stop it.  You're not paid enough to
worry.

