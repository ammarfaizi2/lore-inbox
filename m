Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130227AbQKINbQ>; Thu, 9 Nov 2000 08:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129914AbQKINbG>; Thu, 9 Nov 2000 08:31:06 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55376 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129616AbQKINbC>; Thu, 9 Nov 2000 08:31:02 -0500
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
To: rothwell@holly-springs.nc.us (Michael Rothwell)
Date: Thu, 9 Nov 2000 13:31:40 +0000 (GMT)
Cc: cr@sap.com (Christoph Rohland), richardj_moore@uk.ibm.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <3A0A97D0.36C5913B@holly-springs.nc.us> from "Michael Rothwell" at Nov 09, 2000 07:25:52 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13trnq-00019Y-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> reason to hamstring their efforts because of the possibility of binary
> modules. The GPL allows that, right? So any developer of binary-only

Its not clear the GPL does allow it. 

> extensions using the GKHI would not be breaking the license agreement, I
> don't think. There's lots of binary modules right now -- VMWare, Aureal
> sound card drivers, etc.

All of which just cause large numbers of bugs to go in the bitbucket because
nobody can tell whose the problem is.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
