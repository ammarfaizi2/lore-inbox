Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131231AbRAQGxh>; Wed, 17 Jan 2001 01:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132002AbRAQGx1>; Wed, 17 Jan 2001 01:53:27 -0500
Received: from mail.crc.dk ([130.226.184.8]:15121 "EHLO mail.crc.dk")
	by vger.kernel.org with ESMTP id <S131231AbRAQGxT>;
	Wed, 17 Jan 2001 01:53:19 -0500
Message-ID: <3A65415C.5A0D57F@crc.dk>
Date: Wed, 17 Jan 2001 07:53:16 +0100
From: Mogens Kjaer <mk@crc.dk>
Organization: Carlsberg Laboratory
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: da, en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: nfs client problem in kernel 2.4.0
In-Reply-To: <3A6466E3.AB55716@crc.dk> <shsy9wb334a.fsf@charged.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

> I'll bet it's the lseek that's screwing things up again. IIRC IRIX has
> an export option to cause it to generate 32-bit readdir cookies. Could
> you please try enabling it?

Sorry, I forgot to mention this: This option was already enabled.

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
