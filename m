Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132418AbQLRStD>; Mon, 18 Dec 2000 13:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132451AbQLRSsw>; Mon, 18 Dec 2000 13:48:52 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:54277 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132418AbQLRSso>; Mon, 18 Dec 2000 13:48:44 -0500
Subject: Re: 2.2.18 asm-alpha/system.h has a problem
To: ttabi@interactivesi.com (Timur Tabi)
Date: Mon, 18 Dec 2000 18:20:17 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001218184531Z132357-439+4699@vger.kernel.org> from "Timur Tabi" at Dec 18, 2000 12:15:00 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1484tX-0005xN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> programmer for a C++ programmer.  All the C programmer needs to do is
> acknowledge that someone might want to use a C++ compiler on the code, and just
> make a few minor changes that have no negative affect at all.

All C++ folks need to do is to use

extern "C" {
#include "macrosforthestuffthecplusplusstandardspeoplegotwrong.h"
#include "cheaderfile"
#include "nowmakethemacrosgoaway.h"
}

where those redefine new private etc

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
