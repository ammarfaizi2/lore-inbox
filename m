Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262664AbSKROIZ>; Mon, 18 Nov 2002 09:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262662AbSKROIZ>; Mon, 18 Nov 2002 09:08:25 -0500
Received: from mailout.mbnet.fi ([194.100.161.24]:45574 "EHLO posti.mbnet.fi")
	by vger.kernel.org with ESMTP id <S262664AbSKROIX> convert rfc822-to-8bit;
	Mon, 18 Nov 2002 09:08:23 -0500
Message-ID: <000701c28f10$3dca1de0$5ea564c2@windows>
From: "Matti Annala" <gval@mbnet.fi>
To: "Kernel Mailinglist" <linux-kernel@vger.kernel.org>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>
References: <001b01c28d51$fd9a2400$5ca464c2@windows> <1037491709.24769.22.camel@irongate.swansea.linux.org.uk>
Subject: Re: [PATCH] ide.h cleanup, 2.5.47
Date: Mon, 18 Nov 2002 16:39:01 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
X-OriginalArrivalTime: 18 Nov 2002 14:14:17.0025 (UTC) FILETIME=[C78F9310:01C28F0C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
To: "Matti Annala" <gval@mbnet.fi>
Cc: "Kernel Mailinglist" <linux-kernel@vger.kernel.org>; "Dave Jones" <davej@suse.de>
Sent: Sunday, November 17, 2002 2:08 AM
Subject: Re: [PATCH] ide.h cleanup, 2.5.47


> On Sat, 2002-11-16 at 09:24, Matti Annala wrote:
> > The patch below performs minor cleanups on the include/linux/ide.h header. It
> > simplifies the use of endianness #ifdefs and removes a chunk of duplicated
> > code.
> > 
> > Comments?
> 
> Why are you deleting chunks of comments ?
> 

The comments and the #define statement that the patch is deleting are duplicated in the header as you may see by checking the header file.

