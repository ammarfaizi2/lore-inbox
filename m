Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131182AbRAQJhq>; Wed, 17 Jan 2001 04:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131658AbRAQJhg>; Wed, 17 Jan 2001 04:37:36 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:15880 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S131182AbRAQJhX>;
	Wed, 17 Jan 2001 04:37:23 -0500
Message-ID: <3A6567CF.E10FDEBD@mandrakesoft.com>
Date: Wed, 17 Jan 2001 04:37:19 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeffrey Rose <Jeffrey.Rose@t-online.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 config breaks /dev/fd0* major/minor ?
In-Reply-To: <3A656749.ACF3F01A@t-online.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeffrey Rose wrote:
> I get a wrong major/minor reported when attempting
> to mount /dev/fd0 ... 

Sounds like it can't find the floppy driver, for whatever reason...

-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
