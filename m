Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132284AbQLNEBZ>; Wed, 13 Dec 2000 23:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132318AbQLNEBP>; Wed, 13 Dec 2000 23:01:15 -0500
Received: from getafix.lostland.net ([216.29.29.27]:9321 "EHLO
	getafix.lostland.net") by vger.kernel.org with ESMTP
	id <S132284AbQLNEA6>; Wed, 13 Dec 2000 23:00:58 -0500
Date: Wed, 13 Dec 2000 22:29:49 -0500 (EST)
From: adrian <jimbud@lostland.net>
To: Ivan Vadovic <pivo@pobox.sk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: IP ID == 0 ?!
In-Reply-To: <20001214041109.A997@ivan.doma>
Message-ID: <Pine.BSO.4.30.0012132226340.719-100000@getafix.lostland.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

On Thu, 14 Dec 2000, Ivan Vadovic wrote:

> Hi,
[snip]
> help here. Did I forget to configure something?

Did you configure IP: TCP Explicit Congestion Notification support?  If
so, this breaks some older firewalls, which probably won't be updated any
time soon.

Regards,
Adrian



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
