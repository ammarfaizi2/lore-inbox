Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133053AbRADOd6>; Thu, 4 Jan 2001 09:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130151AbRADOds>; Thu, 4 Jan 2001 09:33:48 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:23310 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129477AbRADOdj>; Thu, 4 Jan 2001 09:33:39 -0500
Subject: Re: 2.4.0-prerelease: System dies after leaving XF86_4.0.2
To: nbreun@gmx.de
Date: Thu, 4 Jan 2001 14:35:43 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01010406154500.01435@nmb> from "Norbert Breun" at Jan 04, 2001 06:15:45 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14EBUX-0005nN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've tested 2.4.0prerelease pure - ac1-ac2-ac3-ac4-ac5 and my system crashed 
> whenever I left X. 
> Having switched back to 2.4.0-test13pre7 all is fine. 
> I'm no developer, so if you need more information, give me some hints.

What video card do you have and are you using AGP or DRM (an lsmod will tell
you)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
