Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129534AbRAYHiQ>; Thu, 25 Jan 2001 02:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131516AbRAYHiH>; Thu, 25 Jan 2001 02:38:07 -0500
Received: from hermes.mixx.net ([212.84.196.2]:16905 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129921AbRAYHhv>;
	Thu, 25 Jan 2001 02:37:51 -0500
Message-ID: <3A6FD7A0.B45964A8@innominate.com>
Date: Thu, 25 Jan 2001 08:37:04 +0100
From: Juri Haberland <juri.haberland@innominate.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Jeremy Hansen <jeremy@xxedgexx.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: hotmail not dealing with ECN
In-Reply-To: <Pine.LNX.4.21.0101250041440.1498-100000@srv2.ecropolis.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Hansen wrote:
> 
> Just curious if others have noticed that hotmail is unable to deal with
> ECN and wondering if this is a standard that should be encouraged, as in
> should I tell hotmail that perhaps they should look into supporting it, or
> should I not waste my breath and echo 0 > /proc/sys/net/ipv4/tcp_ecn?

Forget it. I mailed them and this is the answer:

"As ECN is not a widely used internet standard, and as Cisco does not
have a stable OS for their routers that accepts ECN, anyone attempting
to access our site through a gateway or from a computer that uses ECN
will be unable to do so."

Juri

-- 
juri.haberland@innominate.com
system engineer                                         innominate AG
clustering & security                            the linux architects
tel: +49-30-308806-45   fax: -77            http://www.innominate.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
