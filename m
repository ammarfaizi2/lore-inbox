Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbRBPAjA>; Thu, 15 Feb 2001 19:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129104AbRBPAiv>; Thu, 15 Feb 2001 19:38:51 -0500
Received: from [64.160.188.242] ([64.160.188.242]:49926 "HELO
	mail.hislinuxbox.com") by vger.kernel.org with SMTP
	id <S129066AbRBPAij>; Thu, 15 Feb 2001 19:38:39 -0500
Date: Thu, 15 Feb 2001 16:38:37 -0800 (PST)
From: "David D.W. Downey" <pgpkeys@hislinuxbox.com>
To: <linux-kernel@vger.kernel.org>
Subject: [OTP] SMP board recommendations?
Message-ID: <Pine.LNX.4.30.0102151634380.16783-100000@ns-01.hislinuxbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Anyone have a recommendation for a motherboard for a homebased SMP box?

I've tried the Abit VP6 and the MSI 6321 (694D Pro). Both give me the APIC
errors with system lockups on heavy I/O using the 2.4.1-ac1# and the
2.4.2-pre# kernels. (The ac-## line doesn't die ANYWHERE near as often as
the other board.)

I'm looking into the i810 server board with the onboard SCSI controllers.
I plan on installing either the Promise PDC20267 ATA100 controller or a
Promise FastTrak RAID card (if they come in ATA100) since the only SCSI I
have is the Yamaha 8424S SCSI CDR-W.

Since this IS off topic of sorts, please reply to me privately. Thanks


-- 
David D.W. Downey - RHCE
Consulting Engineer
Ensim Corporation - Sunnyvale, CA

