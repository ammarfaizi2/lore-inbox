Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132416AbRBEAMl>; Sun, 4 Feb 2001 19:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132427AbRBEAMc>; Sun, 4 Feb 2001 19:12:32 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:64528 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S132416AbRBEAMR>;
	Sun, 4 Feb 2001 19:12:17 -0500
Message-ID: <3A7DEFD2.F5BF5175@mandrakesoft.com>
Date: Sun, 04 Feb 2001 19:12:02 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: modversions.h source pollution in 2.4
In-Reply-To: <26206.981331639@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> Maintainers: please fix these sources by removing modversions.h.
[...]
> drivers/net/epic100.c
> drivers/net/starfire.c

Fixed.

	Jeff



-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
