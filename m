Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265102AbRGBNOt>; Mon, 2 Jul 2001 09:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265100AbRGBNOj>; Mon, 2 Jul 2001 09:14:39 -0400
Received: from t2.redhat.com ([199.183.24.243]:37617 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S265085AbRGBNOf>; Mon, 2 Jul 2001 09:14:35 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <E15H3C2-0005qS-00@the-village.bc.nu> 
In-Reply-To: <E15H3C2-0005qS-00@the-village.bc.nu> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: sjhill@cotw.com, adam@yggdrasil.com (Adam J. Richter),
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: linux-2.4.6-pre8/drivers/mtd/nand/spia.c: undefined symbols 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 02 Jul 2001 14:14:23 +0100
Message-ID: <28944.994079663@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@lxorguk.ukuu.org.uk said:
>  So the Config.in is wrong since I can select spia on x86 

Yep. I've added a few more dependencies like that to the map drivers too. I
heard rumours that someone else had done similar changes, but nobody sent me
a patch so those rumours can't be true.

I'll wait for Steven to fix this up and then send all those changes to
Linus.

Assuming, that is, that nobody else takes it upon themselves to keep
resending small bits of the pending changes, gratuitously making it harder
to me to keep in sync.

--
dwmw2


