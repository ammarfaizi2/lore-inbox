Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266378AbUFQFbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266378AbUFQFbw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 01:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266376AbUFQFbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 01:31:52 -0400
Received: from smtp-out5.xs4all.nl ([194.109.24.6]:22542 "EHLO
	smtp-out5.xs4all.nl") by vger.kernel.org with ESMTP id S266378AbUFQFbv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 01:31:51 -0400
Date: Thu, 17 Jun 2004 07:31:37 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: color corruption (white becomes pink) in 16 bpp radeonfb
Message-ID: <20040617053137.GA14869@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

when used at 16 bpp, any white in the picture becomes pink when using
fbi to view some .jpgs on the console.
This didn't happen with 2.6.7-rc3-mm2.

It also affects the bootup-penguins: there's a black background, and
only a pink silhouette inside.

Kernel command line: root=/dev/md3 video=radeonfb:1600x1200-16@85

Jurriaan
-- 
8)  "Marketing Statistics":  How to claim 99% of the people sent your
spam LIKED it because only 10 people out of 1000 complained, (even
though you hijacked a server and made it near impossible to trace or
reply to).
	'Top ten seminars at an upcoming DMA conference' as seen in nanae
Debian (Unstable) GNU/Linux 2.6.7 2x6078 bogomips load 0.32
