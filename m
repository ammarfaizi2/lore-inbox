Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129112AbRBFQCQ>; Tue, 6 Feb 2001 11:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129063AbRBFQCG>; Tue, 6 Feb 2001 11:02:06 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:6408 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S129051AbRBFQBy>; Tue, 6 Feb 2001 11:01:54 -0500
Message-ID: <3A801FEA.E622B306@Hell.WH8.TU-Dresden.De>
Date: Tue, 06 Feb 2001 17:01:46 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac3 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Dale Farnsworth <dale@farnsworth.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: VIA silent disk corruption - patch
In-Reply-To: <20010206085223.A28894@zenos.local.farnsworth.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dale Farnsworth wrote:
> 
> However, if I enable the BIOS parameter "I/O Recovery Time", I can still
> enable read caching without seeing any data corruption.
> The lastest BIOS revision (1005C) enables "I/O Recovery Time" by default
> where the previous revision I had (1004D) did not.

Interesting stuff.

Asus, Germany released 1005D today. It's available from
ftp://ftp.asuscom.de/pub/ASUSCOM/BIOS/Socket_A/VIA_Chipset/Apollo_KT133/A7V/1005D.zip

No comments about what they changed and/or fixed.

-Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
