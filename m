Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129097AbQKHWkH>; Wed, 8 Nov 2000 17:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129145AbQKHWj6>; Wed, 8 Nov 2000 17:39:58 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:18696 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129097AbQKHWjs>;
	Wed, 8 Nov 2000 17:39:48 -0500
Message-ID: <3A09D60F.2A5C1990@mandrakesoft.com>
Date: Wed, 08 Nov 2000 17:39:11 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Feuer <David_Feuer@brown.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: pcmcia
In-Reply-To: <4.3.2.7.2.20001108172304.00adb270@postoffice.brown.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Feuer wrote:
> 
> What is the current status of PC-card support?  I've seen ominous signs on
> this list about the state of support....  I have a laptop with a PCMCIA
> network card (a 3com thing). Will it work?

It should, yes.  Enable hotplug, cardbus, and 3com vortex/boomerang
support...

-- 
Jeff Garzik             | "When I do this, my computer freezes."
Building 1024           |          -user
MandrakeSoft            | "Don't do that."
                        |          -level 1
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
