Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274299AbRITEvh>; Thu, 20 Sep 2001 00:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274308AbRITEv2>; Thu, 20 Sep 2001 00:51:28 -0400
Received: from c007-h012.c007.snv.cp.net ([209.228.33.219]:18142 "HELO
	c007.snv.cp.net") by vger.kernel.org with SMTP id <S274299AbRITEvP>;
	Thu, 20 Sep 2001 00:51:15 -0400
X-Sent: 20 Sep 2001 04:51:33 GMT
Message-ID: <3BA9740D.DD16AE9E@distributopia.com>
Date: Wed, 19 Sep 2001 23:43:57 -0500
From: "Christopher K. St. John" <cks@distributopia.com>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.0.36 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [PATCH] /dev/epoll update ...
In-Reply-To: <XFMail.20010919192804.davidel@xmailserver.org> <3BA97155.4D2D53AC@distributopia.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Christopher K. St. John" wrote:
> 
> Assume that instead of many very fast
> connections coming in at a furious rate, you get a
> large steady current of very slow connections.
> 

 Sorry, bad editing, that should be:

 Assume a large but bursty current of low bandwidth
high latency connections instead of a continuous steady
flood of high bandwidth low latency connections.


-- 
Christopher St. John cks@distributopia.com
DistribuTopia http://www.distributopia.com
