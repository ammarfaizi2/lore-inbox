Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266161AbTBTRMh>; Thu, 20 Feb 2003 12:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266135AbTBTRMh>; Thu, 20 Feb 2003 12:12:37 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:63760 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S266161AbTBTRMf>; Thu, 20 Feb 2003 12:12:35 -0500
Date: Thu, 20 Feb 2003 18:21:45 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: PaceBlade broken acpi/memory map
Message-ID: <20030220172144.GA15016@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have PaceBlade here, and its memory map is wrong, which leads to
ACPI refusing to load. [It does not mention "ACPI data" in the memory
map at all!]

And when I work around that, it crashes in processing _STA/_INI
methods. [Anyone from PaceBlade listening?]

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
