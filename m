Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129597AbQLOXpk>; Fri, 15 Dec 2000 18:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131024AbQLOXpb>; Fri, 15 Dec 2000 18:45:31 -0500
Received: from [216.191.170.20] ([216.191.170.20]:26637 "EHLO
	mail.truetech.com") by vger.kernel.org with ESMTP
	id <S129597AbQLOXpU>; Fri, 15 Dec 2000 18:45:20 -0500
Message-ID: <001d01c066ec$910df560$0caabfd8@truetech.com>
From: "Ratko Vidakovic" <ratko@truetech.com>
To: <linux-kernel@vger.kernel.org>
Subject: select() call crash
Date: Fri, 15 Dec 2000 18:12:59 -0500
Organization: TrueTech Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 Hi,

 Im running Redhat 6.2 i386 and Ive recently upgraded to the 2.2.17 kernel.
The reason for the kernel upgrade was that the select() call in one of the
programs I wrote, crashes periodically (once a day in the evening). I was
wondering if anyone has heard of anything like that, and if so, will it be
fixed? I just basically want to know what you guys know, if you know
anything about
a select() call crash.

 -Ratko, TrueTech


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
