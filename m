Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129444AbRAYIgA>; Thu, 25 Jan 2001 03:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129534AbRAYIfu>; Thu, 25 Jan 2001 03:35:50 -0500
Received: from mail.crc.dk ([130.226.184.8]:37390 "EHLO mail.crc.dk")
	by vger.kernel.org with ESMTP id <S129444AbRAYIfg>;
	Thu, 25 Jan 2001 03:35:36 -0500
Message-ID: <3A6FE550.2208427C@crc.dk>
Date: Thu, 25 Jan 2001 09:35:28 +0100
From: Mogens Kjaer <mk@crc.dk>
Organization: Carlsberg Laboratory
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: da, en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, rdale@digital-mission.com
Subject: Re: agpgart (2.4.0 kernel)
In-Reply-To: <Pine.LNX.4.10.10101241752450.20959-300000@vs-01.digipath.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Dale wrote:
> 
> I have agpgart compiled into the kernel with both (Intel 440LX/BX/GX and
> I815/I840/I850) and Intel I810/I815 drivers.  When the kernel boots I get:
> 
>   Linux agpgart interface v0.99 (c) Jeff Hartmann
>   agpgart: Maximum main memory to use for agp memory: 27M
>   agppart: agpgart: Detected an Intel i815, but could not find
>   the secondary device.

You can try one of the 2.4.0-ac kernels or look in the lkml archives
for a threeline patch.

Mogens
-- 
Mogens Kjaer, Carlsberg Laboratory, Dept. of Chemistry
Gamle Carlsberg Vej 10, DK-2500 Valby, Denmark
Phone: +45 33 27 53 25, Fax: +45 33 27 47 08
Email: mk@crc.dk Homepage: http://www.crc.dk
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
