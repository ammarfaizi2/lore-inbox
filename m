Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263527AbRFAOWY>; Fri, 1 Jun 2001 10:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263530AbRFAOWO>; Fri, 1 Jun 2001 10:22:14 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:64775 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263527AbRFAOV5>; Fri, 1 Jun 2001 10:21:57 -0400
Subject: Re: [PATCH] support for Cobalt Networks (x86 only) systems (for
To: bogdan.costescu@iwr.uni-heidelberg.de (Bogdan Costescu)
Date: Fri, 1 Jun 2001 15:19:45 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        bogdan.costescu@iwr.uni-heidelberg.de (Bogdan Costescu),
        zaitcev@redhat.com (Pete Zaitcev),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.33.0106011503030.18082-100000@kenzo.iwr.uni-heidelberg.de> from "Bogdan Costescu" at Jun 01, 2001 03:06:22 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E155pmD-0000Zv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No way! If I implement a HA application which depends on link status, I
> want the info to be accurate, I don't want to know that 30 seconds ago I
> had good link.
> 
> IMHO, rate limiting is the only solution.

Please re-read your comment. Then think about it. Then tell me how rate limiting
differs from caching to the application.

Alan

