Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261926AbRFFLm7>; Wed, 6 Jun 2001 07:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261956AbRFFLmt>; Wed, 6 Jun 2001 07:42:49 -0400
Received: from [212.1.33.3] ([212.1.33.3]:47380 "EHLO borg4.zapnet.de")
	by vger.kernel.org with ESMTP id <S261926AbRFFLml>;
	Wed, 6 Jun 2001 07:42:41 -0400
From: Ivan Schreter <is@zapwerk.com>
To: linux-kernel@vger.kernel.org
Subject: Buffer management - interesting idea
Date: Wed, 6 Jun 2001 13:39:27 +0200
X-Mailer: KMail [version 1.0.29.2]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <01060613422800.07218@linux>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm working on some hi-speed DB projects under Linux and I was researching
various buffer-replacement algorithms. I found 2Q buffer replacement policy at

	http://citeseer.nj.nec.com/63909.html

Maybe it would be interesting to use it instead of LRU for disk buffer
replacement. Seems relatively easy to implement and costs are about the same as
for LRU.

I'm not subscribed to the list, so replies please CC: to me (is@zapwerk.com).


Ivan Schreter
is@zapwerk.com
