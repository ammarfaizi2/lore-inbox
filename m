Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbUKCT0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbUKCT0r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 14:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbUKCTZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 14:25:57 -0500
Received: from mx.inch.com ([216.223.198.27]:36365 "EHLO util.inch.com")
	by vger.kernel.org with ESMTP id S261826AbUKCTXS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 14:23:18 -0500
Date: Tue, 2 Nov 2004 16:53:08 -0500
From: John McGowan <jmcgowan@inch.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.9: i810 video
Message-ID: <20041102215308.GA3579@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.6.9

Let's see ... in 2.6.8(.1) one could not burn audio CDs.

In kernel 2.6.9 it seems that the Intel i810 video driver is useless (junk
on the screen ... lockup) and one can no longer compile alsa-lib-1.0.6 from
the source at alsa-project.org. That's as far as I got before I now have to
recompile the working 2.6.7 (if only gimp worked with it ...).

I guess I have to go back to kernel 2.6.7 and await 2.6.10.

(Fedora Core2: xorg-x11-6.8.1-4 from RPM, gcc-3.3.3-7, most of my .config
               for kernel 2.6.9 a duplicate of what was working in 2.6.7)
