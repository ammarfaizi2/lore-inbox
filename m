Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132008AbQLLPxn>; Tue, 12 Dec 2000 10:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131922AbQLLPxd>; Tue, 12 Dec 2000 10:53:33 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:37644 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S132008AbQLLPxP>;
	Tue, 12 Dec 2000 10:53:15 -0500
Message-ID: <3A3642C6.7D50A6AE@mandrakesoft.com>
Date: Tue, 12 Dec 2000 10:22:46 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Swapping-over-nbd deadlock fixed?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see in the 2.2.18 release notes that a deadlock, related to swapping
over a network via nbd, was fixed.  Is this bug present in 2.4.x-test?
-- 
Jeff Garzik         |
Building 1024       | These are not the J's you're lookin' for.
MandrakeSoft        | It's an old Jedi mind trick.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
