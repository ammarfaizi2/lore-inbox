Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132548AbQLJAtY>; Sat, 9 Dec 2000 19:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132572AbQLJAtG>; Sat, 9 Dec 2000 19:49:06 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:51976 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S132548AbQLJAsp>; Sat, 9 Dec 2000 19:48:45 -0500
Date: Sat, 9 Dec 2000 18:13:51 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bob Lorenzini <hwm@ns.newportharbornet.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18-25 DELL Laptop Video Problems
Message-ID: <20001209181351.C15531@vger.timpanogas.org>
In-Reply-To: <20001209160027.A15007@vger.timpanogas.org> <E144sZd-0005q5-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E144sZd-0005q5-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Dec 09, 2000 at 10:34:30PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2000 at 10:34:30PM +0000, Alan Cox wrote:
> > Id there a workaround for this for DELL laptops.  Frame buffer needs
> > to be enabled because you don't really know what system you are on
> > until after it installs, and the X probing stuff needs it enabled in
> > order to properly detect the hardware.  Any ideas?
> 
> Hard to be sure. Without knowing precisely which board they have and which
> options you used I can't guess which code path changed


I will get this information on Monday when the testing person at Canopy 
is in.  We wer testing with their equipment.  I'll get you the info.

Jeff

> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
