Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129545AbQKBHzf>; Thu, 2 Nov 2000 02:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129624AbQKBHzZ>; Thu, 2 Nov 2000 02:55:25 -0500
Received: from pD9040D51.dip.t-dialin.net ([217.4.13.81]:38409 "HELO
	grumbeer.hjb.de") by vger.kernel.org with SMTP id <S129545AbQKBHzN>;
	Thu, 2 Nov 2000 02:55:13 -0500
Subject: Re: test10 won't boot
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Thu, 2 Nov 2000 08:54:00 +0100 (CET)
Cc: hjb@pro-linux.de (Hans-Joachim Baader), linux-kernel@vger.kernel.org
In-Reply-To: <3A0112C8.E7D1117C@mandrakesoft.com> from "Jeff Garzik" at Nov 02, 2000 02:07:52 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20001102075400.5D2F13DFC7F@grumbeer.hjb.de>
From: hjb@pro-linux.de (Hans-Joachim Baader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Hans-Joachim Baader wrote:
> > test10, compiled with gcc 2.95.2, won't boot on one of my machine.
> > It stops after the "now booting the kernel" message. Yes, I have
> > configured Virtual Terminal and VGA text console.
> 
> Does it boot with the attached patch?

Nope, it doesn't. Same observation.

BTW this was the first 2.4 kernel that I tried on this machine.
So I cannot say since when it's broken. 2.2.x works fine.

Regards,
hjb
-- 
http://www.pro-linux.de/ - Germany's largest volunteer Linux support site
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
