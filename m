Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129521AbQLLXK2>; Tue, 12 Dec 2000 18:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129904AbQLLXKS>; Tue, 12 Dec 2000 18:10:18 -0500
Received: from pop.gmx.net ([194.221.183.20]:7993 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S129521AbQLLXKJ>;
	Tue, 12 Dec 2000 18:10:09 -0500
Message-ID: <02b301c0648c$6c030470$0301a8c0@nonevy4mxm86ct>
From: "Thomas Kotzian" <thomasko321k@gmx.at>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.0-test12 doesn't start under vmware
Date: Tue, 12 Dec 2000 23:39:37 +0100
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

I compiled linux-2.4.0-test12 without any problems:
it does:
Lilo:
loading v240t12 .........
Uncompressing Linux... Ok, booting the kernel.

then it is in an endless loop i think because vmware uses all cpu-power.
First I start in Grub, from there i start Lilo and then the kernel. - maybe
there's a problem?

Thomas

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
