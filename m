Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284794AbSBCCQB>; Sat, 2 Feb 2002 21:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285073AbSBCCPm>; Sat, 2 Feb 2002 21:15:42 -0500
Received: from fep01-mail.bloor.is.net.cable.rogers.com ([66.185.86.71]:51152
	"EHLO fep01-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id <S284794AbSBCCPh>; Sat, 2 Feb 2002 21:15:37 -0500
Message-ID: <002001c1ac58$a948bae0$0300000a@hypnos>
From: "Jon Anderson" <jon-anderson@rogers.com>
To: <linux-kernel@vger.kernel.org>
Subject: 760MPX IO/APIC Errors...
Date: Sat, 2 Feb 2002 21:15:33 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep01-mail.bloor.is.net.cable.rogers.com from [24.112.215.28] using ID <jon-anderson@rogers.com> at Sat, 2 Feb 2002 21:15:31 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was previouly discussed on this list, but there wasn't really a helpful
answer that I could find on the archives.

Anyway, I'm running an Asus A7M266-D with a single Morgan core Duron
(default everything, no overclocking).

I get this repeatedly:
APIC error on CPU0: 04(04)

This happens with APIC or SMP enabled in the kernel. I recompiled the kernel
without APIC support, and the errors are gone (no surprise there! :-) There
doesn't appear to be any instability, or other negative side effects. I've
basically recompiled the kernel ~5 times without problems.

What I'd like to know is, what are those APIC errors - causes, etc? Do they
matter? (Are these actual errors caused by some hardware malfunction that
may be damaging my CPU/Board?)

Any information anyone could give me would be great,

Thanks,

jon anderson

