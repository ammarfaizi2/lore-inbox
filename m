Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131317AbRAWPaP>; Tue, 23 Jan 2001 10:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131313AbRAWPaF>; Tue, 23 Jan 2001 10:30:05 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:38162 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S131310AbRAWP34>;
	Tue, 23 Jan 2001 10:29:56 -0500
Message-ID: <3A6DA2F8.D47EDB0A@mandrakesoft.com>
Date: Tue, 23 Jan 2001 10:27:52 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jonathan Earle <jearle@nortelnetworks.com>
CC: "'Linux Kernel List'" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1-test10
In-Reply-To: <28560036253BD41191A10000F8BCBD116BDCCC@zcard00g.ca.nortel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Earle wrote:
> Have you looked at the packet loss issue on the Znyx 4port cards?  Even
> using the latest tulip driver, packet loss is still apparent with moderate
> loads.

I replied privately; but I just wanted to add that bug reports for the
in-kernel Tulip driver should be sent to the bug tracking system at
http://sourceforge.net/projects/tulip/

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
