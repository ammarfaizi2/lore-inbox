Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbQLRXrY>; Mon, 18 Dec 2000 18:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129477AbQLRXrP>; Mon, 18 Dec 2000 18:47:15 -0500
Received: from c1262263-a.grapid1.mi.home.com ([24.183.135.182]:26130 "EHLO
	mail.neruo.com") by vger.kernel.org with ESMTP id <S129431AbQLRXrG>;
	Mon, 18 Dec 2000 18:47:06 -0500
Subject: Re: APM bug with Inspiron 5000e
From: Brad Douglas <brad@neruo.com>
To: volodya@mindspring.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.20.0012162303120.2738-100000@node2.localnet.net>
Content-Type: text/plain
X-Mailer: Evolution 0.8 (Developer Preview)
Date: 18 Dec 2000 15:15:29 -0800
Mime-Version: 1.0
Message-Id: <20001218234708Z129431-439+4801@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Dec 2000 23:05:45 -0500,  wrote:
> 
> I am seeing this bug with both test8 and test12 kernels. Help/suggestions
> for debugging are appreciated.
> 
> Computer: Inspiron 5000e. 
> Bug: oops when doing cat /proc/apm.
> 
>                       Vladimir Dergachev


What's the BIOS revision it claims to have during POST?  It should be
A0x (where x is a number).

Thanks,

Brad Douglas
brad@neruo.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
