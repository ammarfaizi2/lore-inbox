Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131124AbRANBgd>; Sat, 13 Jan 2001 20:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131415AbRANBgY>; Sat, 13 Jan 2001 20:36:24 -0500
Received: from linuxcare.com.au ([203.29.91.49]:34056 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S131124AbRANBgM>; Sat, 13 Jan 2001 20:36:12 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Sun, 14 Jan 2001 12:34:21 +1100
To: Ron Calderon <ronnnyc@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sparc10 with 512M of RAM hangs on boot
Message-ID: <20010114123421.F20398@linuxcare.com>
In-Reply-To: <20010113034809.28919.qmail@web1001.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010113034809.28919.qmail@web1001.mail.yahoo.com>; from ronnnyc@yahoo.com on Fri, Jan 12, 2001 at 07:48:09PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> every kernel after 2.4.0-test5 hangs my sparc10
> at the same spot. Has anyone looked into this?
> here is screen output:

Yep I know about this but need to iron out another bug with the patches
before I commit them.

Anton
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
