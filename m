Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289014AbSBMWVm>; Wed, 13 Feb 2002 17:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289015AbSBMWVW>; Wed, 13 Feb 2002 17:21:22 -0500
Received: from inet-mail3.oracle.com ([148.87.2.203]:40636 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S289014AbSBMWVT>; Wed, 13 Feb 2002 17:21:19 -0500
Message-ID: <3C6AE72D.1010803@oracle.com>
Date: Wed, 13 Feb 2002 23:22:37 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: elenstev@mesatop.com, David Hinds <dhinds@zen.stanford.edu>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.4, add help texts to drivers/net/pcmcia/Config.help
In-Reply-To: <200202131712.KAA02867@tstac.esa.lanl.gov> <3C6AAC49.F099129E@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Thanks, patch pushed into the local queue here for 2.5.

The Xircom one is wrong though - driver will be called xircom_cb.o,
  not xircom_tulip_cb.o (that's the name of the older driver).

--alessandro

  "If your heart is a flame burning brightly
    you'll have light and you'll never be cold
   And soon you will know that you just grow / You're not growing old"
                               (Husker Du, "Flexible Flyer")

