Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271324AbTGQJlV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 05:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271357AbTGQJlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 05:41:21 -0400
Received: from dhcp065-024-247-070.insight.rr.com ([65.24.247.70]:39040 "EHLO
	family") by vger.kernel.org with ESMTP id S271324AbTGQJlV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 05:41:21 -0400
Date: Thu, 17 Jul 2003 05:56:16 -0400
To: linux-kernel@vger.kernel.org
Subject: linux 2.5+2.6 SiS 730 DRM/DRI
Message-ID: <20030717095616.GA27930@acolyte.merseine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: nick@acolyte.merseine.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i've recently upgraded to 2.6.0-test on my machines. one of them has a sis 730 video card
built into the motherboard. as i recall, the 2.4.21 kernel allowed you to compile in DRM support for SiS 630/730 cards 
in the "Character Devices" section under DRM. i've checked DRI support with glxinfo in 2.4.21 and direct rendering is
enabled, while in 2.6 it is not. do the 2.6(and 2.5) kernels have support for DRM with the SiS 630/730 chipset? i know the config
has changed, is there anything i have to compile in so i can get DRI working with these cards? the framebuffer device, frambebuffer
console and agpgart are working fine. 
