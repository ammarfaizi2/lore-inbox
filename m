Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131118AbQLLFzp>; Tue, 12 Dec 2000 00:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131231AbQLLFzf>; Tue, 12 Dec 2000 00:55:35 -0500
Received: from cy60022-a.vnnys1.ca.home.com ([24.21.33.25]:28932 "EHLO
	cy60022-a.home.com") by vger.kernel.org with ESMTP
	id <S131118AbQLLFzZ>; Tue, 12 Dec 2000 00:55:25 -0500
From: Android <android@abac.com>
Reply-To: android@abac.com
Organization: Androids Unlimited
Date: Mon, 11 Dec 2000 21:24:22 +0000
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
To: linux-kernel@vger.kernel.org
In-Reply-To: <E145f1E-0000a9-00@the-village.bc.nu>
In-Reply-To: <E145f1E-0000a9-00@the-village.bc.nu>
Subject: Re: Linux 2.2.18 release notes
MIME-Version: 1.0
Message-Id: <00121121242201.00885@cy60022-a>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>           ... added basic support for the Pentium IV. Unfortunately Intel 
chose to
>           ignore all precedent in model numbering via cpuid and report a
>           family of '15'. This sudden jump broke assumptions in the
>           kernel tree without any warning. Intel have failed to provide
>           good reasons for their change. We have chosen to continue to
>           report the Pentium IV as a '686' class processor. The full
>           family data is provided via cpuinfo.
>
>           In addition the early Pentium IV chips appear to have some
>           problems. You should be using stepping 7 or higher processors
>           with the latest shipping microcode update if you wish to run
>           Linux on a Pentium IV processor.
>
>           + Intel Pentium IV support


How is the Pentium IV more advanced than the Pentium III, other than speed?
Why would LInux care about a 1500 MHz clock or 400 MHz bus speed?
Just treat the PIV as a faster PIII. 

                                  -- Ted
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
