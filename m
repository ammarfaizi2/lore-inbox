Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129705AbQKHTy5>; Wed, 8 Nov 2000 14:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129706AbQKHTyr>; Wed, 8 Nov 2000 14:54:47 -0500
Received: from jimbo.uss.sco.COM ([132.147.144.106]:27908 "EHLO
	jimbo.uss.sco.com") by vger.kernel.org with ESMTP
	id <S129705AbQKHTyf>; Wed, 8 Nov 2000 14:54:35 -0500
Message-ID: <3A09BD3E.9F2FAF04@sco.com>
Date: Wed, 08 Nov 2000 12:53:18 -0800
From: Jim Bonnet <jimbo@sco.com>
Organization: The Santa Cruz Operation
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sb.o support in 2.4-broken?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using the 2.4.0-test10 kernel. I have a sound blaster 16 which
works fine under 2.2.17.

I see that a while back someone posted on this problem previously but
there were no answers I can find..

Is support for soundblaster16 ISA broken in the 2.4 kernel? Compiled in
or used as a module I can not get it to work. I have passed sb=220,5,1,5
during boot when compiled in and also sent those during insmod.

When I boot to 2.2.17 these are the correct values and sound is happy :)

I am subbed to this group so you may answer here so this is on record.

Thanks much...


-- 
Jim Bonnet
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
