Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136019AbRAGQuf>; Sun, 7 Jan 2001 11:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136001AbRAGQuZ>; Sun, 7 Jan 2001 11:50:25 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:36623 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136019AbRAGQuI>; Sun, 7 Jan 2001 11:50:08 -0500
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission
To: hadi@cyberus.ca (jamal)
Date: Sun, 7 Jan 2001 16:51:11 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), davem@redhat.com (David S. Miller),
        ak@suse.de, greearb@candelatech.com, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
In-Reply-To: <Pine.GSO.4.30.0101071102140.18916-100000@shell.cyberus.ca> from "jamal" at Jan 07, 2001 11:12:23 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14FJ2H-0002vI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok. Good point.
> But remember that parsing /proc for an embedded system is also not the
> most healthy thing.

I dont compile in /proc either. SIOCGIFCONF is enough for an embedded box.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
