Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264561AbUEJIku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264561AbUEJIku (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 04:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264562AbUEJIku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 04:40:50 -0400
Received: from ns.suse.de ([195.135.220.2]:12940 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264561AbUEJIks (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 04:40:48 -0400
Date: Mon, 10 May 2004 10:39:05 +0200
From: Olaf Hering <olh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.6
Message-ID: <20040510083905.GA18603@suse.de>
References: <Pine.LNX.4.58.0405091954240.3028@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0405091954240.3028@ppc970.osdl.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sun, May 09, Linus Torvalds wrote:

> Holler if I missed anything,

add 'chmod -Rf a+rX,o-w,g-w .' to your release scripts.

cp -a linux-2.6.6/ linux-2.6.6.xxx
cp: cannot open `linux-2.6.6/arch/arm/mm/proc-v6.S' for reading: Permission denied
cp: cannot open `linux-2.6.6/arch/arm/mm/cache-v6.S' for reading: Permission denied
cp: cannot open `linux-2.6.6/arch/arm/mm/abort-ev6.S' for reading: Permission denied
cp: cannot open `linux-2.6.6/arch/arm/mm/copypage-v6.c' for reading: Permission denied
cp: cannot open `linux-2.6.6/arch/arm/mm/tlb-v6.S' for reading: Permission denied
cp: cannot open `linux-2.6.6/arch/arm/mm/blockops.c' for reading: Permission denied
cp: cannot open `linux-2.6.6/drivers/char/agp/isoch.c' for reading: Permission denied
cp: cannot open `linux-2.6.6/drivers/input/joystick/grip_mp.c' for reading: Permission denied
cp: cannot open `linux-2.6.6/Documentation/networking/netif-msg.txt' for reading: Permission denied
cp: cannot open `linux-2.6.6/Documentation/scsi/ChangeLog.megaraid' for reading: Permission denied



-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
