Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268489AbTGIReN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 13:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268490AbTGIReN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 13:34:13 -0400
Received: from rtichy.netro.cz ([213.235.180.210]:56052 "HELO 192.168.1.21")
	by vger.kernel.org with SMTP id S268489AbTGIReJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 13:34:09 -0400
Message-ID: <02ff01c34642$5512d7f0$401a71c3@izidor>
From: "Milan Roubal" <roubm9am@barbora.ms.mff.cuni.cz>
To: <linux-kernel@vger.kernel.org>, <mru@users.sourceforge.net>
References: <Pine.LNX.4.53.0307091413030.683@mx.homelinux.com> <027901c3461e$e023c670$401a71c3@izidor> <yw1xadbnx017.fsf@users.sourceforge.net>
Subject: Re: Promise SATA 150 TX2 plus
Date: Wed, 9 Jul 2003 16:51:13 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So other question - is there SATA controler that
is working in linux multiple controlers (4 cards)
and is for better bus than standart PCI? Like PCI-X or
PCI 66 MHz like promise is?
Thanks for answer
    Milan Roubal

----- Original Message ----- 
From: <mru@users.sourceforge.net>
To: <linux-kernel@vger.kernel.org>
Sent: Wednesday, July 09, 2003 4:11 PM
Subject: Re: Promise SATA 150 TX2 plus


"Milan Roubal" <roubm9am@barbora.ms.mff.cuni.cz> writes:

> Thanks for the answer, it has got PDC 20375, not
> 20376, but it changes nothing. As Alan mentioned
> here: http://marc.theaimsgroup.com/?l=linux-kernel&m=105440080221319&w=2
> promise has got their own drivers. Have somebody seen
> this drivers really working? My card is not RAID,
> its only controller, I want only see the harddrives.

Do yourself a favor, and get a Highpoint card instead.

-- 
Måns Rullgård
mru@users.sf.net

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

