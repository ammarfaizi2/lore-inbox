Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129726AbRBLO4V>; Mon, 12 Feb 2001 09:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129883AbRBLO4L>; Mon, 12 Feb 2001 09:56:11 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:23314 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129726AbRBLOzx>; Mon, 12 Feb 2001 09:55:53 -0500
Subject: Re: [PATCH] new version of the starfire driver for 2.2.19pre
To: ionut@cs.columbia.edu (Ion Badulescu)
Date: Mon, 12 Feb 2001 14:56:03 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0102120245310.4687-100000@age.cs.columbia.edu> from "Ion Badulescu" at Feb 12, 2001 02:47:12 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14SKOc-0007Bz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But the driver _does_ work without the firmware, it only loses the
> hardware TCP checksum on Rx capability. That's what we have in 2.4.x right 
> now, why should 2.2.x be pickier and *demand* to have the firmware or no 
> support at all?

Ok I didnt realise the firmware thing was tcp checksum paths only. Thats fine
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
