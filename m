Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272966AbRIHG3q>; Sat, 8 Sep 2001 02:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272967AbRIHG3g>; Sat, 8 Sep 2001 02:29:36 -0400
Received: from paloma12.e0k.nbg-hannover.de ([62.159.219.12]:45253 "HELO
	paloma12.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S272966AbRIHG3V>; Sat, 8 Sep 2001 02:29:21 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Robert Love <rml@tech9.net>
Subject: Re: Linux Preemptive patch success 2.4.10-pre4 + lots of other
Date: Sat, 8 Sep 2001 08:29:03 +0200
X-Mailer: KMail [version 1.3]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20010908062932Z272966-761+7898@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> I am glad you take a pro side to the preemption issue.  Hopefully I can
> get some continued support and see some work towards inclusion in 2.5. 
> Any help is appreciated.

I've tested your former patch against 2.4.7-acX and sent you some feedback 
but you didn't answered my post.

Is the module problem (missing preempt_xxx symbols) thing fixed?

Aside from that I saw some nice speed increase (UP Athlon) and very snappy 
system.

dbench-1.1 32 clients load drops to mostly below 16 (33 before)

Go on with your great work!

Greetings,
	Dieter

-- 
Dieter Nützel
Graduate Student, Computer Science
University of Hamburg
