Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285285AbRLFXO6>; Thu, 6 Dec 2001 18:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285287AbRLFXOs>; Thu, 6 Dec 2001 18:14:48 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:8196 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285285AbRLFXOd>; Thu, 6 Dec 2001 18:14:33 -0500
Subject: Re: link error in usbdrv.o (2.4.17-pre5)
To: will_dyson@pobox.com (Will Dyson)
Date: Thu, 6 Dec 2001 23:23:43 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C0FFACF.4060806@pobox.com> from "Will Dyson" at Dec 06, 2001 06:10:07 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16C7rj-0003Xs-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When compiling 2.4.17-pre5 with the usb compiled in, the final link 
> produces the following error:

Downgrade your Debian binutils to the previous version rather than the
one in the snapshot of the week. (Its probably fair to say its not the
binutils fault thats just the fix)
