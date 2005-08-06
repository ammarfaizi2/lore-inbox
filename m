Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262134AbVHFMHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbVHFMHS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 08:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262334AbVHFMHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 08:07:18 -0400
Received: from smtp.bredband2.net ([82.209.166.4]:56122 "EHLO
	smtp.bredband2.net") by vger.kernel.org with ESMTP id S262115AbVHFMHP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 08:07:15 -0400
Message-ID: <42F4A7DD.70905@home.se>
Date: Sat, 06 Aug 2005 14:06:53 +0200
From: =?ISO-8859-1?Q?John_B=E4ckstrand?= <sandos@home.se>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, akpm@osdl.org
Subject: Re: assertion (cnt <= tp->packets_out) failed
References: <42F38B67.5040308@home.se> <20050805.093208.74729918.davem@davemloft.net> <20050806022435.GB12862@gondor.apana.org.au> <20050806075717.GA18104@gondor.apana.org.au>
In-Reply-To: <20050806075717.GA18104@gondor.apana.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hang on a second, the original poster mentioned rc5.  Is this really
> pristine rc5 with the one netpoll patch? If so then it can't be the
> patches we're talking about because they only went in days later.

Yes, I have no other patches in, so if it was not in -RC5, I was not 
running it.

---
John Bäckstrand
