Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRADVMP>; Thu, 4 Jan 2001 16:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129413AbRADVMF>; Thu, 4 Jan 2001 16:12:05 -0500
Received: from sls.lcs.mit.edu ([18.27.0.167]:38118 "EHLO sls.lcs.mit.edu")
	by vger.kernel.org with ESMTP id <S129183AbRADVLx>;
	Thu, 4 Jan 2001 16:11:53 -0500
Message-ID: <3A54E717.11A43B42@sls.lcs.mit.edu>
Date: Thu, 04 Jan 2001 16:11:51 -0500
From: I Lee Hetherington <ilh@sls.lcs.mit.edu>
Organization: MIT Laboratory for Computer Science
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.18-pre25.1.smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Dell Precision 330 (Pentium 4, i850 chipset, 3c905c)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anybody get this working with 2.2.18 or 2.4.0-prerelease?  I can't seem
to get the on-board 3c905c to work.  I've seen it without an interrupt
assignment in /proc/interrupts.  With Red Hat's pump (DHCP), it sends
packets out but doesn't seem to see the response.

I can provide more details.

--Lee Hetherington


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
