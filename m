Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315257AbSHFRkm>; Tue, 6 Aug 2002 13:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315259AbSHFRkm>; Tue, 6 Aug 2002 13:40:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51471 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315257AbSHFRkk>;
	Tue, 6 Aug 2002 13:40:40 -0400
Message-ID: <3D500AF1.9050901@mandrakesoft.com>
Date: Tue, 06 Aug 2002 13:44:17 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Russell, Nathaniel" <reddog83@chartermi.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trivial patch for 2.4.20-pre1 8139too.c driver  (fwd)
References: <web-46527136@back1.chartermi.net>
X-Enigmail-Version: 0.65.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell, Nathaniel wrote:
> My i ask what the sense is to not remove the dead code if
>  all we are trying to do is stablize the 2.4x kernel series
>  and not add extra code or change around the drivers for
>  perticular hardware. The code is not used anymore so why
>  keep it in the 2.4x series. The code can stay in the 2.5x
>  series no problem because there we can change drivers
>  rewrite hardware protocalls and tthings like that. 


...because I maintain the driver, and want to keep that code around as a 
note to myself.

	Jeff



