Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129722AbQKJLnC>; Fri, 10 Nov 2000 06:43:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130686AbQKJLmx>; Fri, 10 Nov 2000 06:42:53 -0500
Received: from [203.116.59.243] ([203.116.59.243]:33029 "HELO
	aries.starnet.gov.sg") by vger.kernel.org with SMTP
	id <S129722AbQKJLmo>; Fri, 10 Nov 2000 06:42:44 -0500
Message-ID: <001101c04b0b$53cc5f40$050010ac@starnet.gov.sg>
From: "Corisen" <csyap@starnet.gov.sg>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <20001110112146.12035.qmail@web1103.mail.yahoo.com>
Subject: compiling 2.4.0-test10 kernel
Date: Fri, 10 Nov 2000 19:42:38 +0800
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

hi,

i'm currently running RH7, with 2.2.16-22 kernel, gcc 2.96 on a Sharp Actius
250 notebook.

i've manged to successfully compile 2.4.0-test10 kernel. however, upon
startup there are some failed/error messages:
1. finding module dependencies: depmod *** Unresolved symbols in
/lib/modules/2.4.0-test10/kernel/arch/i386/kernel/apm.o
2. Starting NFS lockd: lockdsvc: Invalid argument [FAILED]

during shutdown, the following failed messages was noticed:
1. Turning off accounting: aacton: Function not implemented
2. Shutting down NFS lockd [FAILED]

the system is also not able to shutdown/power off completely after
"shutdown -h now". however, using RH7 2.2.16 kernel, the notebook was able
to power off. how can i configure it to turn off automatically?

pls kindly advise where i have gone wrong and how to rectify the above
errors.

pls pardon my ignorance as i'm quite new to linux and this is my first
kernel compilation attempt.

thank you very much.

ps: i've tried the kernel compilation on a HP Vectra PII PC and the error
messages are similar.




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
