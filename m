Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130232AbRBAK6J>; Thu, 1 Feb 2001 05:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130340AbRBAK57>; Thu, 1 Feb 2001 05:57:59 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:43533 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130232AbRBAK5r>; Thu, 1 Feb 2001 05:57:47 -0500
Subject: Re: spelling of disc (disk) in /devfs
To: peter@cadcamlab.org (Peter Samuelson)
Date: Thu, 1 Feb 2001 10:58:40 +0000 (GMT)
Cc: jmd@foozle.turbogeek.org (Jeremy M. Dolan),
        alan@chandlerfamily.org.uk (Alan Chandler),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010201042813.C27725@cadcamlab.org> from "Peter Samuelson" at Feb 01, 2001 04:28:13 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14OHRq-00048M-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Richard Gooch (devfs author, from Australia) to switch to the American
> spelling of the word, for consistency with the rest of the kernel, and

Pardon

include/linux/console_struct.h:	unsigned char   vc_palette[16*3];       /* Colour palette for VGA+ */
include/linux/dio.h:#define DIO_ID2_HRCCATSEYE  0x06 /* highres colour "catseye" */
include/linux/kd.h:#define GIO_CMAP	0x4B70	/* gets colour palette on VGA+ */
include/linux/kd.h:#define PIO_CMAP	0x4B71	/* sets colour palette on VGA+ */
include/linux/videodev.h:	__u16	colour;

etc..

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
