Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267033AbSLKG4R>; Wed, 11 Dec 2002 01:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267035AbSLKG4R>; Wed, 11 Dec 2002 01:56:17 -0500
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:15116 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S267033AbSLKG4Q>; Wed, 11 Dec 2002 01:56:16 -0500
X-Envelope-From: roubm9am@barbora.ms.mff.cuni.cz
Message-ID: <043801c2a0e3$3fea3850$551b71c3@krlis>
From: "Milan Roubal" <roubm9am@barbora.ms.mff.cuni.cz>
To: "Milton D. Miller II" <miltonm@realtime.net>
Cc: <linux-kernel@vger.kernel.org>
References: <200212110626.gBB6Qvt37089@sullivan.realtime.net>
Subject: Re: IDE feature request & problem
Date: Wed, 11 Dec 2002 08:02:15 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
its only once in log - then the software raid made
that disk fail and removed from the array:
Nov 28 17:54:24 fileserver kernel: raid5: Disk failure on hdn1, disabling
device. Operation continuing on 8 devices
I don't want anymore disabled drive, that is good.
    Thanx Milan

----- Original Message -----
From: "Milton D. Miller II" <miltonm@realtime.net>
To: "Milan Roubal" <roubm9am@barbora.ms.mff.cuni.cz>
Cc: <linux-kernel@vger.kernel.org>
Sent: Wednesday, December 11, 2002 7:26 AM
Subject: Re: IDE feature request & problem


> (Barry pointed out the errors are all 7F.)
>
> And the sector LBA is hex 808087F7F7F  (high 80808 low 7f7f7f)
>
> do you get this repeatedly?
>
> milton

