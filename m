Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129486AbQKJACZ>; Thu, 9 Nov 2000 19:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130557AbQKJACP>; Thu, 9 Nov 2000 19:02:15 -0500
Received: from avocet.prod.itd.earthlink.net ([207.217.121.50]:22689 "EHLO
	avocet.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S129486AbQKJACH>; Thu, 9 Nov 2000 19:02:07 -0500
To: jamagallon@able.es
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Mandrake Kernel <kernel@linux-mandrake.com>
Subject: Re: Errors in 2.4-test11 build
In-Reply-To: <20001109023950.A4777@werewolf.able.es>
	<m38zqszyxb.fsf@matrix.mandrakesoft.com>
	<20001110005704.G747@werewolf.able.es>
From: Chmouel Boudjnah <chmouel@mandrakesoft.com>
Date: 09 Nov 2000 16:01:44 -0800
In-Reply-To: <20001110005704.G747@werewolf.able.es>
Message-ID: <m33dh0r8yf.fsf@matrix.mandrakesoft.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J . A . Magallon" <jamagallon@able.es> writes:

> A suggestion. People being able to build kernels with egcs or other version,
> would not be this suitable for another entry in /var/lib/rpm/alternatives,
> named kgcc, and with priorities gcc-2.91.66, gcc-2.95.2, gcc-2.7.2.3, gcc-2.96 ?

this could be a good idea, but i don't want to set kgcc for gcc-2.96,
and we have only (in cooker) egcs- and gcc-2.96 in the main/
ditstrib. 

Ok and BTW: this problem is only for the mandrake devlopement
distribution (cooker) 7.2 out of the box egcs/kgcc should work fine.

-- 
MandrakeSoft Inc                     http://www.chmouel.org
                      --Chmouel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
