Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130414AbRCBLnE>; Fri, 2 Mar 2001 06:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130416AbRCBLmz>; Fri, 2 Mar 2001 06:42:55 -0500
Received: from law2-oe32.hotmail.com ([216.32.180.25]:18959 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S130414AbRCBLmi>;
	Fri, 2 Mar 2001 06:42:38 -0500
X-Originating-IP: [192.128.254.68]
From: "Lorenzo Quatrini" <quatrini@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: Looking for MP-BIOS-less patch
Date: Fri, 2 Mar 2001 12:39:37 +0100
MIME-Version: 1.0
Content-Type: text/plain;	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Message-ID: <LAW2-OE32KCaEt87SUw000061e4@hotmail.com>
X-OriginalArrivalTime: 02 Mar 2001 11:42:28.0828 (UTC) FILETIME=[DC0F81C0:01C0A30D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have found an old NCR 3430 system (with MCA, and proprietary MP board)
As of now, I was able to install and recompile linux on it (2.2.14-5.0 and
2.2.18), but I haven't found any way to get smp running.
As far as I know the NCR is not Intel MP compliant.

Looking on the ml archive I found a post from Ingo Molnar for a
"MP-BIOS-less" patch, but I could'nt find it.

So I asking if I can find a patch or there is some boot-parameter for the
kernel 2.2.14 or 2.2.18 or even 2.4.0 for forcing linux to go in MP mode
without an MP compliant Bios.

Thanks in advance
Best regards

        Lorenzo Quatrini


P.S.     I'm new to this ml, and I'm not a kernel developer,but I'm just
searching for help, so let me know if I should'nt post here.
            Before posting here I deeply searched for help in the FAQ and
other sources, but I could'n find anything, so I decided to ask for your
help.
