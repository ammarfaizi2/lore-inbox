Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318969AbSHSSRT>; Mon, 19 Aug 2002 14:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318970AbSHSSRT>; Mon, 19 Aug 2002 14:17:19 -0400
Received: from web13008.mail.yahoo.com ([216.136.174.18]:17171 "HELO
	web13008.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S318969AbSHSSRS>; Mon, 19 Aug 2002 14:17:18 -0400
Message-ID: <20020819182121.93059.qmail@web13008.mail.yahoo.com>
Date: Mon, 19 Aug 2002 11:21:21 -0700 (PDT)
From: Xuehua Chen <namniardniw@yahoo.com>
Subject: A question about cache coherence
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Met a problem in my research. I run some code on a
Xeon
dual-processor machine. It seems to me that there is a
 cache coherence problem. As I am not so familiar 
to this topic, I would like to ask some experts about 
the following questions.

1. Do Xeon processors have hardware mechanisms to
maintain cache coherence?
2. Does the SMP kernel handle the cache coherence
problem
3. What should I do if both of them don't handle cache
coherence.

Thanks.

Frank Samuel

__________________________________________________
Do You Yahoo!?
HotJobs - Search Thousands of New Jobs
http://www.hotjobs.com
