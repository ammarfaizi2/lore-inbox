Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261971AbVEWVMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbVEWVMc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 17:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbVEWVMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 17:12:31 -0400
Received: from hell.sks3.muni.cz ([147.251.210.30]:44995 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S261971AbVEWVMU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 17:12:20 -0400
Date: Mon, 23 May 2005 23:12:15 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: DVD eject
Message-ID: <20050523211215.GB2604@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have problem with my dvd+-r/rw driver in laptop. 

It's: (kernel 2.6.12-rc3)
hdb: TSSTcorpCD/DVDW TS-L532A, ATAPI CD/DVD-ROM drive

When I mount and umount any disk, then tray cannot be ejected using cdrom
button. Eject program works but it complains with errors:

hdb: irq timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hdb: DMA disabled
hdb: ATAPI reset complete
hdb: irq timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
hdb: ATAPI reset complete

Is there something I could try? (Mainly to get cdrom eject button working)

-- 
Luká¹ Hejtmánek
