Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280619AbRKFWKt>; Tue, 6 Nov 2001 17:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280623AbRKFWKi>; Tue, 6 Nov 2001 17:10:38 -0500
Received: from ns1.ltc.com ([38.149.17.165]:18951 "HELO ns1.ltc.com")
	by vger.kernel.org with SMTP id <S280622AbRKFWK2>;
	Tue, 6 Nov 2001 17:10:28 -0500
Message-ID: <030301c1670f$ecfbcd60$3501010a@ltc.com>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: "Patrick Allaire" <pallaire@gameloft.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <9A1957CB9FC45A4FA6F35961093ABB8405445491@srvmail-mtl.ubisoft.qc.ca>
Subject: Re: Kernel booting on serial console ... crawling
Date: Tue, 6 Nov 2001 17:11:03 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've seen something like that when my serial driver wasn't getting
interrupts.

Regards,
Brad

"Patrick Allaire" <pallaire@gameloft.com> said:
> I tried to boot my kernel using the serial console, using the
> console=ttyS0,115200 (it does the same thing with 9600) ... it work great
> until :
>
> Freeing unused kernel memory: 36k freed
> serial console detected.  Disabling virtual terminals.
> console=/dev/ttyS0
>
> At this point the output of the serial line slow down dramaticly ...
almost
> to a halt ... I get 1 line every 30 seconds !!!

