Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130000AbQKCAbz>; Thu, 2 Nov 2000 19:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130013AbQKCAbq>; Thu, 2 Nov 2000 19:31:46 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:24069 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129544AbQKCAbd>;
	Thu, 2 Nov 2000 19:31:33 -0500
Message-ID: <3A0206CF.81023491@mandrakesoft.com>
Date: Thu, 02 Nov 2000 19:29:03 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rob Landley <telomerase@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 255.255.255.255 won't broadcast to multiple NICs
In-Reply-To: <20001102235538.25699.qmail@web5205.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
> Under 2.2.16, broadcast packets addressed to
> 255.255.255.255 do not go out to all interfaces in a
> machine with multiple network cards.  They're getting
> routed out the default gateway's interface instead.

Are the network cards on the same network?

-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
