Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317279AbSGRAnV>; Wed, 17 Jul 2002 20:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317354AbSGRAnV>; Wed, 17 Jul 2002 20:43:21 -0400
Received: from spud.dpws.nsw.gov.au ([203.202.119.24]:36556 "EHLO
	spud.dpws.nsw.gov.au") by vger.kernel.org with ESMTP
	id <S317279AbSGRAnS>; Wed, 17 Jul 2002 20:43:18 -0400
Message-Id: <sd369c76.061@out-gwia.dpws.nsw.gov.au>
X-Mailer: Novell GroupWise Internet Agent 6.0.1
Date: Thu, 18 Jul 2002 10:45:49 +1000
From: "Daniel Lim" <Daniel.Lim@dpws.nsw.gov.au>
To: <linux-kernel@vger.kernel.org>
Subject: kernel patch problem
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-NAIMIME-Disclaimer: 1
X-NAIMIME-Modified: 1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have Redhat 7.1 kernel 2.4.2-2 and I wish to apply all latest
incremental patches from 2.4.3 -> 2.4.18 to resolve a kernel issue but I
am having problem to apply the 1st patch which is 2.4.3, I got the
patch-2.4.3.gz from http://www.linuxhq.com/kernel 

Enclosed below is what I did and followed by whole heaps of failed
mesages? Any suggestion please.
Thanks in advance.

Regards,
Daniel

# cd /usr/src
# zcat patch-2.4.3.gz | patch -p0

patching file linux/CREDITS
Hunk #2 FAILED at 316.
Hunk #4 FAILED at 676.
Hunk #5 succeeded at 1015 (offset -4 lines).
Hunk #7 FAILED at 2182.
3 out of 7 hunks FAILED -- saving rejects to file linux/CREDITS.rej
patching file linux/Documentation/Changes
patching file linux/Documentation/Configure.help
Reversed (or previously applied) patch detected!  Assume -R? [n]
Apply anyway? [n] y
Hunk #1 FAILED at 1521.
Hunk #2 succeeded at 2042 (offset 62 lines).
Hunk #3 succeeded at 2131 with fuzz 2 (offset 87 lines).
Hunk #4 succeeded at 5749 (offset 188 lines).
Hunk #5 succeeded at 5708 (offset 87 lines).
Hunk #6 succeeded at 5818 (offset 188 lines).
Hunk #7 succeeded at 5754 (offset 87 lines).
Hunk #8 succeeded at 5876 (offset 188 lines).
Hunk #9 succeeded at 5787 (offset 87 lines).
Hunk #10 succeeded at 7662 (offset 188 lines).
Hunk #11 FAILED at 8712.
Hunk #12 succeeded at 8662 (offset 126 lines).
Hunk #13 FAILED at 8745.
Hunk #14 FAILED at 9663.
Hunk #15 FAILED at 9703.
Hunk #16 FAILED at 9718.
Hunk #17 FAILED at 9728.
Hunk #18 FAILED at 9738.
Hunk #19 FAILED at 9754.
Hunk #20 succeeded at 10850 (offset 198 lines).
9 out of 20 hunks FAILED -- saving rejects to file
linux/Documentation/Configure.help.rej
patching file linux/Documentation/DMA-mapping.txt
patching file linux/Documentation/DocBook/kernel-api.tmpl
Hunk #1 FAILED at 34.
1 out of 1 hunk FAILED -- saving rejects to file
linux/Documentation/DocBook/kernel-api.tmpl.rej
patching file linux/Documentation/SAK.txt
patching file linux/Documentation/arm/SA1100/Brutus
Reversed (or previously applied) patch detected!  Assume -R? [n]






 This e-mail message (and attachments) is confidential, and / or privileged and is intended for the use of the addressee only. If you are not the intended recipient of this e-mail you must not copy, distribute, take any action in reliance on it or disclose it to anyone. Any confidentiality or privilege is not waived or lost by reason of mistaken delivery to you. DPWS is not responsible for any information not related to the business of DPWS. If you have received this e-mail in error please destroy the original and notify the sender.

For information on services offered by DPWS, please visit our website at www.dpws.nsw.gov.au



