Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131412AbQL1Vfo>; Thu, 28 Dec 2000 16:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131230AbQL1Vfe>; Thu, 28 Dec 2000 16:35:34 -0500
Received: from hnlmail3.hawaii.rr.com ([24.25.227.37]:17677 "EHLO
	hawaii.rr.com") by vger.kernel.org with ESMTP id <S131412AbQL1VfQ>;
	Thu, 28 Dec 2000 16:35:16 -0500
Message-ID: <001301c07111$dcca44c0$10a10842@hawaii.rr.com>
From: "Ray Strode" <halfline@hawaii.rr.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BUG] in 2.4.0test12 and earlier
Date: Thu, 28 Dec 2000 11:04:47 -1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've posted these problems several times before, but I've never received
any response, and I'd really like this problems worked out.  I'd be happy
to try anything that I can to assist in the bug tracking process.
Basically,
the kernel locks up on my Alpha PC164 when network load is high.  It
does it with several different NICs. Any ideas?

Also, If I try to compile the kernel for PC164 instead of generic, then the
computer gets irq probe errors for the hard drive, and the computer doesn't
boot.  Any ideas?

I would really appreciate help in solving these problems.

--Ray Strode

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
