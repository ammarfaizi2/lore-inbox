Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129081AbQJaPT3>; Tue, 31 Oct 2000 10:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129232AbQJaPTT>; Tue, 31 Oct 2000 10:19:19 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35176 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129081AbQJaPTN>; Tue, 31 Oct 2000 10:19:13 -0500
Subject: Re: 2.2.17 & VM: do_try_to_free_pages failed / eepro100
To: geoff@farmline.com (Geoff Winkless)
Date: Tue, 31 Oct 2000 15:20:19 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <069c01c0434b$ad0c5a50$1400000a@farmline.com> from "Geoff Winkless" at Oct 31, 2000 03:03:06 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13qdD3-0007zf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > VM: do_try_to_free_pages failed for httpd...
> > VM: do_try_to_free_pages failed for httpd...

These if they are odd ones and the box continues are fine, if you get masses
of them then probably not

> (our quiet periods) the syslog is nearly empty. In extremis it has been
> necessary to reboot the machine by kicking the power button.

Are you using software raid ?

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
