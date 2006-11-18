Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755327AbWKRTH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755327AbWKRTH3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 14:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755330AbWKRTH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 14:07:28 -0500
Received: from [87.69.65.201] ([87.69.65.201]:40874 "EHLO psybear.com")
	by vger.kernel.org with ESMTP id S1755322AbWKRTH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 14:07:27 -0500
From: Dror Levin <spatz@psybear.com>
To: linux-kernel@vger.kernel.org
Subject: boot from efi on x86_64
Date: Sat, 18 Nov 2006 21:07:03 +0200
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611182107.03667.spatz@psybear.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

looking at the kernel source, after constant failures to boot linux on a core 
2 imac, has made me understand that only i386 and ia64 support efi booting, 
but x86_64 does not.
it makes sense, if you think about it... AFAIK, until the new core 2 imacs 
were out there was no x86_64 efi pc, so why should the kernel support it?
i would like to ask that the efi boot code be ported to x86_64 and so people 
would not have to use boot camp and bios emulation to boot linux on new 
imacs.

thank you for your time and help.

P.S.
i'm not currently subscribed to the lkml, so please CC me when you reply.
