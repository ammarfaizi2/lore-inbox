Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313338AbSDJROx>; Wed, 10 Apr 2002 13:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313352AbSDJROv>; Wed, 10 Apr 2002 13:14:51 -0400
Received: from smtp.Lynuxworks.COM ([207.21.185.24]:44293 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP
	id <S313338AbSDJROH>; Wed, 10 Apr 2002 13:14:07 -0400
Message-ID: <3CB47351.3060602@lnxw.com>
Date: Wed, 10 Apr 2002 10:16:01 -0700
From: Petko Manolov <pmanolov@Lnxw.COM>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020402 Debian/2:0.9.9-4
X-Accept-Language: en, bg
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB rtl8150 bug
In-Reply-To: <E16vISP-00031t-00@wagner.rustcorp.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> D: This changes struct rtl8150's flags element to be an unsigned long,
> D: since bitops are done on it.

It was fixed in my latest patch.  I am sorry 64bit archs... :-)


		Petko

