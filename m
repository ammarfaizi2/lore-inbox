Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274228AbRISWYu>; Wed, 19 Sep 2001 18:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274227AbRISWYc>; Wed, 19 Sep 2001 18:24:32 -0400
Received: from defout.telus.net ([199.185.220.240]:3356 "EHLO
	priv-edtnes27-hme0.telusplanet.net") by vger.kernel.org with ESMTP
	id <S274228AbRISWYF>; Wed, 19 Sep 2001 18:24:05 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Brad Pepers <brad@linuxcanada.com>
Organization: Linux Canada Inc.
To: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Athlon bug stomper. Pls apply.
Date: Wed, 19 Sep 2001 16:22:58 -0600
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.33.0109191635310.29593-100000@terbidium.openservices.net> <20010919214317Z274216-760+14235@vger.kernel.org>
In-Reply-To: <20010919214317Z274216-760+14235@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <01091916225800.23716@dragon.linuxcan.com>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed that on my Athalon 1.4GHz system (Asus A7V133), I get results 
quite a bit higher than reported here when running the athalon.c program.  
For example everyone posting seemed to get 4000-5000 cycles per page for the 
clear_page fuctions "faster_clear_page" and "even_faster_clear" while mine is 
in the 6300-6700 range.  Does this indicate I'm missing some BIOS 
optimizations?  Slow memory?  Something else?

-- 
Brad Pepers
brad@linuxcanada.com
