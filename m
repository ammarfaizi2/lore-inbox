Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129422AbQKEOed>; Sun, 5 Nov 2000 09:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129442AbQKEOeY>; Sun, 5 Nov 2000 09:34:24 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:28173 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129422AbQKEOeU>;
	Sun, 5 Nov 2000 09:34:20 -0500
Message-ID: <3A056FCD.DC6E1E54@mandrakesoft.com>
Date: Sun, 05 Nov 2000 09:33:49 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: chrisc@greenbuffalo.com
CC: linux-kernel@vger.kernel.org
Subject: Re: 3c509 Oops with 2.4.0-test10
In-Reply-To: <20001105051623.A269@greenbuffalo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chrisc@greenbuffalo.com wrote:
> 
> When trying to load the 3c509 module into a 2.4.0-test10 kernel, I
> got an Oops as follows. Any help would be appreciated.

Apply this patch. 
http://gtf.org/garzik/kernel/files/patches/2.4/2.4.0-test10/3c509-fix-2.4.0.10.patch.gz

-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
