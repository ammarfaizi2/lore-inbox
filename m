Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbUBWJBL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 04:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbUBWJBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 04:01:11 -0500
Received: from mail.naturesoft.net ([203.145.184.221]:16545 "EHLO
	naturesoft.net") by vger.kernel.org with ESMTP id S261883AbUBWJBG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 04:01:06 -0500
From: "Krishnakumar. R" <krishnakumar@naturesoft.net>
Reply-To: krishnakumar@naturesoft.net
Organization: Naturesoft
To: andreas.hartmann@fiducia.de, linux-kernel@vger.kernel.org
Subject: Re: distinguish two identical network cards
Date: Mon, 23 Feb 2004 14:37:17 +0530
User-Agent: KMail/1.5
References: <OF3A73498C.45F49506-ONC1256E43.002FC840@fiducia.de>
In-Reply-To: <OF3A73498C.45F49506-ONC1256E43.002FC840@fiducia.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402231437.17847.krishnakumar@naturesoft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

If its physically identifying the cards that you want,  
then you can  use 'ethtool' for it.  ' -p ' option of 
ethtool will help you physically identify the cards.

Hope it helps,
Regards,
KK.



> Hello!
>
> I've got a little problem with XSeries machines, containing two identical
> builtin Broadcom NIC's. Is there any chance to get some information, which
> one of the two cards is the upper, and which one is the lower card?
> I need this information, because I want to install a lot of these machines
> automatically.
>
>
> Thank you for every hint,
> kind regards,
> Andreas Hartmann
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
HomePage: http://puggy.symonds.net/~krishnakumar


