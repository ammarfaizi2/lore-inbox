Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129886AbQLIXEE>; Sat, 9 Dec 2000 18:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129853AbQLIXDz>; Sat, 9 Dec 2000 18:03:55 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:29703 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129849AbQLIXDo>; Sat, 9 Dec 2000 18:03:44 -0500
Subject: Re: 2.2.18-25 DELL Laptop Video Problems
To: jmerkey@vger.timpanogas.org (Jeff V. Merkey)
Date: Sat, 9 Dec 2000 22:34:30 +0000 (GMT)
Cc: hwm@ns.newportharbornet.com (Bob Lorenzini), linux-kernel@vger.kernel.org
In-Reply-To: <20001209160027.A15007@vger.timpanogas.org> from "Jeff V. Merkey" at Dec 09, 2000 04:00:27 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E144sZd-0005q5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Id there a workaround for this for DELL laptops.  Frame buffer needs
> to be enabled because you don't really know what system you are on
> until after it installs, and the X probing stuff needs it enabled in
> order to properly detect the hardware.  Any ideas?

Hard to be sure. Without knowing precisely which board they have and which
options you used I can't guess which code path changed


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
