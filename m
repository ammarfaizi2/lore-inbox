Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129818AbQKOQwA>; Wed, 15 Nov 2000 11:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129860AbQKOQvu>; Wed, 15 Nov 2000 11:51:50 -0500
Received: from camus.xss.co.at ([194.152.162.19]:18700 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id <S129818AbQKOQvn>;
	Wed, 15 Nov 2000 11:51:43 -0500
Date: Wed, 15 Nov 2000 17:21:08 +0100 (MET)
From: Martin Hoeller <martin@xss.co.at>
To: Andreas Osterburg <alanos@first.gmd.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Swapping over NFS in Linux 2.4?
In-Reply-To: <00111517064807.29351@bar>
Message-ID: <Pine.LNX.4.02.10011151716580.11820-100000@rimbaud.xss.co.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Because I set up a diskless Linux-workstation, I want to swap over NFS.
> For this purpose I found only patches for "older" Linux-versions (2.0, 2.1,
> 2.2?).
> Does anyone know wheter there are patches for 2.4 or does anyone know
> another solution for this problem?

maybe you want to use the network block device.

have a look at
http://www.xss.co.at/linux/NBD
and ftp://ftp.xss.co.at/pub/Linux/NBD

hth,
- martin

--------------------------------------------------------------------
\       Martin Hoeller          | mailto:martin.hoeller@xss.co.at /    
 \      xS+S Andreas Haumer     | web:   http://www.xss.co.at    /
  \     Karmarschgasse 51/2/20  | phone: +43-1-6060114-30       /
   \    A-1100 Vienna/Austria   | fax:   +43-1-6060114-71      /
    -----------------------------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
