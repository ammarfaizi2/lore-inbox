Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310745AbSCHI63>; Fri, 8 Mar 2002 03:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310747AbSCHI6T>; Fri, 8 Mar 2002 03:58:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54030 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310745AbSCHI6H>;
	Fri, 8 Mar 2002 03:58:07 -0500
Message-ID: <3C887D34.4BE740F9@mandrakesoft.com>
Date: Fri, 08 Mar 2002 03:58:28 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel list <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@transmeta.com>
Subject: Caution about e100...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note to all,

I merged e100 into 2.5.x to get it some wider testing and feedback.  The
driver currently has several PCI posting bugs particularly, and other
outstanding bugs that need zapping before the driver will be considered
stable.

DO NOT USE THIS DRIVER IN PRODUCTION.

After these bugs are fixed and it has received wider testing and
feedback, only then will it be merged into the stable 2.4.x series.

I recommend all vendors avoid this driver, for the moment.  It is for
developers, testers, and early adopters only.  It should be ok for
normal use, but edge cases are not yet zapped.

</PSA>

-- 
Jeff Garzik      | Usenet Rule #2 (John Gilmore): "The Net interprets
Building 1024    | censorship as damage and routes around it."
MandrakeSoft     |
