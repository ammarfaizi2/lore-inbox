Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129095AbQKDQRZ>; Sat, 4 Nov 2000 11:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129165AbQKDQRP>; Sat, 4 Nov 2000 11:17:15 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:16656 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129095AbQKDQRE>;
	Sat, 4 Nov 2000 11:17:04 -0500
Message-ID: <3A043674.79C48723@mandrakesoft.com>
Date: Sat, 04 Nov 2000 11:16:52 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Elmer Joandi <elmer@ylenurme.ee>
CC: linux-kernel@vger.kernel.org
Subject: Re: OOPS: 2.4.0-test10 3c509,isapnp,SMP
In-Reply-To: <Pine.LNX.4.10.10011041807150.30056-100000@yle-server.ylenurme.sise>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Elmer Joandi wrote:
> 
> At mandrake bootup, both isapnp and 3c509 as modules

http://gtf.org/garzik/kernel/files/patches/2.4/2.4.0-test10/3c509-fix-2.4.0.10.patch.gz

You need this patch for 3c509 to work as a module in 2.4.0-test10...

-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
