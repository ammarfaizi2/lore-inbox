Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131796AbRAKQAQ>; Thu, 11 Jan 2001 11:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132287AbRAKQAG>; Thu, 11 Jan 2001 11:00:06 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:781 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S131796AbRAKP76>; Thu, 11 Jan 2001 10:59:58 -0500
Message-ID: <3A5DD86B.1EC84550@Hell.WH8.TU-Dresden.De>
Date: Thu, 11 Jan 2001 16:59:39 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac6 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0-ac6
In-Reply-To: <E14GX1V-0001T5-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> 2.4.0-ac6
> o       Fix athlon crash on boot with local apic/nmi    (Ingo Molnar)

Still crashes here with -ac6 on my Athlon. I'll have to write down the
oops by hand later on or set up a serial console, but once that's done
I'll post the trace - unless someone already knows what's still wrong
with it.

-Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
