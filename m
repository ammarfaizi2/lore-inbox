Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265694AbUBBRCS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 12:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265710AbUBBRCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 12:02:18 -0500
Received: from marcoport.ecogen.unibo.it ([137.204.175.100]:10385 "EHLO
	crono.olimpo.ddts.net") by vger.kernel.org with ESMTP
	id S265694AbUBBRCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 12:02:17 -0500
Date: Mon, 2 Feb 2004 18:01:25 +0100
From: Marco Giordani <marco@bononia.it>
To: Hugang <hugang@soulinfo.com>
Cc: swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: swsusp2 on ppc [Re: Software Suspend 2.0]
Message-ID: <20040202170125.GA5245@cs.unibo.it>
Mail-Followup-To: Hugang <hugang@soulinfo.com>,
	swsusp-devel <swsusp-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040201150827.2858bf9b@localhost>
X-Operating-System: Debian GNU/Linux unstable
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 01, 2004 at 03:08:27PM +0800, Hugang wrote:
> Here is the ppc swsusp2 update patch for 2.6.1 + rc6 + 2.0, please
> apply.

It doesn't work for me. During "write cache" phase, at 75% of the
progress bar, my powerbook powers off the LCD backlight and it seems
locked... at this point I can only power off the system...  Any idea?

BTW, I cannot compile your patch with highmem support. It will be very
useful for me...

I've also tried the benh's pmdisk patch and it works fine but it lacks
highmem support too.

TIA,
Marco

-- 
  Marco Giordani <giordani@cs.unibo.it> - GnuPGid 0x229B1BE8/1024
  Key fingerprint = F1C8 CD45 210D 6C19 A5FD  A864 FA01 3E5C 229B 1BE8
