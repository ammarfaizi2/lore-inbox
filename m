Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261562AbRFBVjf>; Sat, 2 Jun 2001 17:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261616AbRFBVjY>; Sat, 2 Jun 2001 17:39:24 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:59152 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261562AbRFBVjM>; Sat, 2 Jun 2001 17:39:12 -0400
Subject: Re: MII access (was [PATCH] support for Cobalt Networks (x86 only)
To: bogdan.costescu@iwr.uni-heidelberg.de (Bogdan Costescu)
Date: Sat, 2 Jun 2001 22:37:01 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), mark@somanetworks.com (Mark Frazer),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        zaitcev@redhat.com (Pete Zaitcev),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        netdev@oss.sgi.com
In-Reply-To: <Pine.LNX.4.33.0106022302250.23145-100000@kenzo.iwr.uni-heidelberg.de> from "Bogdan Costescu" at Jun 02, 2001 11:36:33 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E156J4v-0002BA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Then it needs to be privileged
> 
> Fine. Can you think of a default value for expiring cache ?

Yeah .. so long as its a default and tunable in /proc.

> 

