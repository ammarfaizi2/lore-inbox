Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267401AbSKPXej>; Sat, 16 Nov 2002 18:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267402AbSKPXei>; Sat, 16 Nov 2002 18:34:38 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:36273 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267401AbSKPXei>; Sat, 16 Nov 2002 18:34:38 -0500
Subject: Re: [PATCH] ide.h cleanup, 2.5.47
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matti Annala <gval@mbnet.fi>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@suse.de>
In-Reply-To: <001b01c28d51$fd9a2400$5ca464c2@windows>
References: <001b01c28d51$fd9a2400$5ca464c2@windows>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Nov 2002 00:08:28 +0000
Message-Id: <1037491709.24769.22.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-11-16 at 09:24, Matti Annala wrote:
> The patch below performs minor cleanups on the include/linux/ide.h header. It
> simplifies the use of endianness #ifdefs and removes a chunk of duplicated
> code.
> 
> Comments?

Why are you deleting chunks of comments ?

