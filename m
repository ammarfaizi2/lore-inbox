Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265369AbTBFF6Z>; Thu, 6 Feb 2003 00:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265382AbTBFF6Z>; Thu, 6 Feb 2003 00:58:25 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:59141 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S265369AbTBFF6Y>; Thu, 6 Feb 2003 00:58:24 -0500
Date: Thu, 6 Feb 2003 07:07:42 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.5.59 won't boot, 2.5.58 will, how to I use bitkeeper to get 'in between' ?
Message-ID: <20030206060742.GA6458@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Until now, all 2.5.59-based kernels (2.5.59 vanilla, 2.5.59 + vmlinux
patch, 2.5.59-mm[1-8]) hang very early in the boot-process on my system,
right after 'Uncompressing Linux...'

I am willing to try which patch between 2.5.58 and 2.5.59 caused this,
but I can't find out how to extract these patches. If I browse the
linux-2.5 repository on the web-interface @ bitkeeper, I don't see a
message 'And with this patch-set, we've reached 2.5.58 - any patches
after this apply to 2.5.58 and will create 2.5.59 in due time'.

/usr/src/linux/Documentation/BK-usage/ seems to focus more on uploading
patches. There is something on getting the diff between two kernel
versions, but I need finer patches/revisions/changesets. I can see how
to download the initial tree, but what do I do next?

Thanks,
Jurriaan
-- 
In case of fire, do not attempt to use lifts.
(To which was added:)
Try a fire extinguisher.
GNU/Linux 2.4.21-pre3-ac5 SMP/ReiserFS 2x2339 bogomips load av: 0.00 0.16 0.16
