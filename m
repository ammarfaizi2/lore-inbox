Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136049AbRAGQpz>; Sun, 7 Jan 2001 11:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136034AbRAGQpU>; Sun, 7 Jan 2001 11:45:20 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:32783 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135382AbRAGQpD>; Sun, 7 Jan 2001 11:45:03 -0500
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission
To: matti.aarnio@zmailer.org (Matti Aarnio)
Date: Sun, 7 Jan 2001 16:46:14 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), greearb@candelatech.com (Ben Greear),
        davem@redhat.com (David S. Miller), linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
In-Reply-To: <20010107173306.C25076@mea-ext.zmailer.org> from "Matti Aarnio" at Jan 07, 2001 05:33:06 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14FIxT-0002ue-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	I just tried to pull data from another machine, which
> 	is on normal port thru VLAN trunking port to receiving
> 	machine, and got fast-ether at wire speed. (As near as
>	ncftp's 11.11 MB/sec is wirespeed..)

But talking between two vlans on the same physical lan you will go in and back
out via the switch and you wont
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
