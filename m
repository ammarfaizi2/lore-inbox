Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751063AbVICQDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbVICQDY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 12:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbVICQDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 12:03:24 -0400
Received: from ybbsmtp08.mail.mci.yahoo.co.jp ([210.80.241.157]:23182 "HELO
	ybbsmtp08.mail.mci.yahoo.co.jp") by vger.kernel.org with SMTP
	id S1751063AbVICQDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 12:03:23 -0400
X-Apparently-From: <takeharu1219@yahoo.co.jp>
Message-ID: <4319C948.1080009@ybb.ne.jp>
Date: Sun, 04 Sep 2005 01:03:20 +0900
From: Takeharu KATO <takeharu1219@ybb.ne.jp>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [TRIVAL] Runtime linkage fix for serial_cs
References: <43196393.2040801@ybb.ne.jp> <20050903100010.A29708@flint.arm.linux.org.uk>
In-Reply-To: <20050903100010.A29708@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> You need to find out why your tree doesn't export
> serial8250_unregister_port().  Mis-merged patch maybe?
> 
Thank you for your response.
I'll check our kernel again.


