Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130250AbQKRVPT>; Sat, 18 Nov 2000 16:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131061AbQKRVPJ>; Sat, 18 Nov 2000 16:15:09 -0500
Received: from smtp02.mrf.mail.rcn.net ([207.172.4.61]:62710 "EHLO
	smtp02.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S130250AbQKRVOw>; Sat, 18 Nov 2000 16:14:52 -0500
Message-ID: <3A16EA40.4876A8A2@haque.net>
Date: Sat, 18 Nov 2000 15:44:48 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ATA/IDE: dmaproc error 14 testers wanted!
In-Reply-To: <Pine.LNX.4.10.10011181220390.17557-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This isnt the same as "ide_dmaproc: chipset supported ide_dma_timeout
func only: 14" is it? This was on a PIIX4 w/ test11-pre5. I've since
upgraded to test11-pre7 and the problem hasn't surfaced again.

Andre Hedrick wrote:
> 
> If anyone is suffering from the dreaded "dmaproc error 14: unsupported"
> error and want to test a code that could get you out of that deadlock
> please speak up.
> 
> Basically this is an Intel 440BX PIIX4 issues, but the solution is global
> and should work for all cases.
> 
> Regards,
> 
> Andre Hedrick
> CTO Timpanogas Research Group
> EVP Linux Development, TRG
> Linux ATA Development
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
