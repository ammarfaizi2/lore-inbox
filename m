Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129314AbQLKJqt>; Mon, 11 Dec 2000 04:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130460AbQLKJqj>; Mon, 11 Dec 2000 04:46:39 -0500
Received: from [203.116.59.242] ([203.116.59.242]:33296 "HELO
	pisces.starnet.gov.sg") by vger.kernel.org with SMTP
	id <S129314AbQLKJqa>; Mon, 11 Dec 2000 04:46:30 -0500
Message-ID: <004b01c06352$f6e8e4a0$050010ac@starnet.gov.sg>
From: "Corisen" <csyap@starnet.gov.sg>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <E13xJ14-0002Do-00@the-village.bc.nu> <3A17A667.EED80785@marxmeier.com>
Subject: warning during make modules
Date: Mon, 11 Dec 2000 17:15:53 +0800
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

i'm compiling kernel 2.4.0-test11 uder RH7. i've changed the CC= line to use
kgcc, executed "make clean" and "make mrproper". "make menuconfig" and "make
dep" went smoothly. however during the "make modules" process, several
warning messages (shown below) appeared:

{standard input}: Assembler messages:
{standard input}:8: Warning: Ignoring changed section attributes for
.modinfo

pls kindly advise how can i resolve the warning messages, or can i can
safely igonre the warning messages?

thanks.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
