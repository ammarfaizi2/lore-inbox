Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129260AbQLBP2P>; Sat, 2 Dec 2000 10:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129345AbQLBP2F>; Sat, 2 Dec 2000 10:28:05 -0500
Received: from 216-80-74-178.dsl.enteract.com ([216.80.74.178]:4612 "EHLO
	kre8tive.org") by vger.kernel.org with ESMTP id <S129260AbQLBP1t>;
	Sat, 2 Dec 2000 10:27:49 -0500
Date: Sat, 2 Dec 2000 08:08:37 -0600
From: mike@kre8tive.org
To: Kernel ML <linux-kernel@vger.kernel.org>
Subject: libc load error
Message-ID: <20001202080837.A1097@lingas.basement.bogus>
Reply-To: mike@kre8tive.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

Anyone know what causes an error like this:

init: error while loading shared libraries: init: 
symbol __ctype_h, version GLIBC_2.0 not defined in 
file libc.so.6 with link time reference

Booted a 2.2.18pre16 box and it failed to come back
up throwing that message after the unused kernel space
was freed.

Any information is appreciated.

-- 
___________
Thanks,
Mike Elmore
mike@kre8tive.org

"The more you complain, the longer God makes 
you live."
			-unknown

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
