Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136457AbREDRC3>; Fri, 4 May 2001 13:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136458AbREDRCK>; Fri, 4 May 2001 13:02:10 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:12302 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136457AbREDRCG>; Fri, 4 May 2001 13:02:06 -0400
Subject: Re: dhcp problem with realtek 8139 clone with rh 7.1
To: adam@vbfx.com (Adam)
Date: Fri, 4 May 2001 18:05:51 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, johnsonm@redhat.com (Michael K. Johnson)
In-Reply-To: <3AF2D842.3DD33B6A@vbfx.com> from "Adam" at May 04, 2001 12:26:42 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14vj1d-0007es-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've had the same problem with the 8139too drivers and DHCP.  The reason
> I figure it must be the drivers is because in the 2.4.3 kernel, I'm able
> to use the 8139too drivers with DHCP without any problems.  In 2.4.4 it
> locks my system.

Multiple such reports - seems the 8139too update broke stuf - any ideas Jeff,
should I revert to the 2.4.3 one ?
