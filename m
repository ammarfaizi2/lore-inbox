Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267852AbRHJNJD>; Fri, 10 Aug 2001 09:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267912AbRHJNIx>; Fri, 10 Aug 2001 09:08:53 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:30223 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267852AbRHJNIg>; Fri, 10 Aug 2001 09:08:36 -0400
Subject: Re: Writes to mounted devices containing file-systems.
To: root@chaos.analogic.com
Date: Fri, 10 Aug 2001 14:07:50 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux kernel)
In-Reply-To: <Pine.LNX.3.95.1010810075750.10479A-100000@chaos.analogic.com> from "Richard B. Johnson" at Aug 10, 2001 08:43:58 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15VC10-0000wF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Aug 10 08:05:18 quark sendmail[66]: rejecting connections on daemon MTA: load average: 16
> Aug 10 08:05:18 quark sendmail[66]: rejecting connections on daemon MSA: load average: 16
> Aug 10 08:05:33 quark sendmail[66]: rejecting connections on daemon MTA: load average: 13
> Aug 10 08:05:33 quark sendmail[66]: rejecting connections on daemon MSA: load average: 13
> Aug 10 08:05:48 quark sendmail[66]: accepting connections again for daemon MTA

Thats your mailer laughing at someones pitiful attempt to knock it over. 
Sendmail does load protection. Anyone with effectively equivalent or better
bandwidth can always DoS a system. Ask yahoo.

> In this company, they hired a "CIO" who thinks that no computers
> should have any local storage or boot capability. They must all
> boot from some secure (M$) file-server. They will not be allowed
> to have local disks and, horrors -- of course no floppy drives or
> CD-ROMS.

Good policy (well maybe not the choice of fileserver OS) in many
environments. How do you think McDonalds unix based tills run 8) - no
floppy believe me.

> He doesn't care that we are in the business of making software-driven
> machines so we require access to the guts of computers and their
> operating systems.

Smart people migrate, company or division goes out of business, another large
company eventually buys small company that the people who left formed
repeat cycle. 

> So, if it is at all possible to help improve its security without
> hurting its performance very much, it's really a matter of life-or-
> death for Linux. Otherwise "they" will get us.

I think not. Look at the fate of companies whose bosses adopted X.400
because TCP/IP was "some crazy hacker thing" "not industry strength" "had no
telco support" "couldnt provide the needed QoS" ...

Alan
