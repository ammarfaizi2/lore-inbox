Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131964AbQLJD60>; Sat, 9 Dec 2000 22:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132383AbQLJD6P>; Sat, 9 Dec 2000 22:58:15 -0500
Received: from smtp1.ihug.co.nz ([203.109.252.7]:22288 "EHLO smtp1.ihug.co.nz")
	by vger.kernel.org with ESMTP id <S131964AbQLJD6F>;
	Sat, 9 Dec 2000 22:58:05 -0500
Message-ID: <3A32F7F5.28557718@ihug.co.nz>
Date: Sun, 10 Dec 2000 16:26:45 +1300
From: Gerard Sharp <gsharp@ihug.co.nz>
Reply-To: gsharp@ihug.co.nz
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: HPT366 + SMP = slight corruption in 2.3.99 - 2.4.0-11
In-Reply-To: <Pine.LNX.4.10.10012090156060.5191-200000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> This has the missing ide-pci code from 2.2.
> It stablized my BP6 on the HPT core.

The patch had a large amount of ^M's (about 1 per line), but applied
cleanly after being passed through "sed" :)

Unfortunately, it has NOT fixed the problem :(
> 
> Cheers,
> 
> Andre Hedrick
> CTO Timpanogas Research Group
> EVP Linux Development, TRG
> Linux ATA Development
> 
>   ------------------------------------------------------------------------
>                                    Name: ide.2.4.0-t12-7.1207.patch.1
>    ide.2.4.0-t12-7.1207.patch.1    Type: Plain Text (text/plain)
>                                Encoding: base64
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
