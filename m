Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310654AbSDIRvr>; Tue, 9 Apr 2002 13:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310666AbSDIRvq>; Tue, 9 Apr 2002 13:51:46 -0400
Received: from coltrane.siteprotect.com ([64.26.16.13]:34011 "EHLO
	coltrane.siteprotect.com") by vger.kernel.org with ESMTP
	id <S310654AbSDIRvq>; Tue, 9 Apr 2002 13:51:46 -0400
From: "Rob Hall" <rob@compuplusonline.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: 2.5.7,8-pre2 and USB
Date: Tue, 9 Apr 2002 14:00:31 -0400
Message-ID: <BBENIHKKLAMLHIECFJEPAEPHCAAA.rob@compuplusonline.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
	I'm running a Tyan Tiger Dual Athlon motherboard(S2624). This board has an
OHCI USB host controller on-board... I recently compiled 2.5.7, only to find
that the machine halts as soon as the USB HC is detected. Same problem arose
with 2.5.8-pre2.. Has the location of the USB init been changed? If I
recompile the kernel with USB support as modules, and load the appropriate
modules via init script, it works perfectly. Just wondering if this has been
reported by anyone else, and if it is a known issue, what is the cause and
is there a patch yet?


Thanks
--
Rob Hall


