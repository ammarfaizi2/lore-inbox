Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWCTHhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWCTHhe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 02:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWCTHhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 02:37:34 -0500
Received: from math.ut.ee ([193.40.36.2]:14465 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S932170AbWCTHhe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 02:37:34 -0500
Date: Mon, 20 Mar 2006 09:29:36 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Adrian Bunk <bunk@stusta.de>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: spontaneous reboots with latest 2.6.16 RC-s
In-Reply-To: <20060305162905.GC20287@stusta.de>
Message-ID: <Pine.SOC.4.61.0603200926260.1662@math.ut.ee>
References: <Pine.SOC.4.61.0603021501560.23598@math.ut.ee>
 <20060305162905.GC20287@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It could be, but it could also be hardware.

It seems to be the hardware. The machine has rebooted with both older 
Xorg and kernels back to 2.6.14 so the software that worked doesn't work 
anymore. Additionally it has rebooted with just rtorrent+lynx with no 
console activity at all, and other new situations, so it really looks 
it's the hardware (probably the capacitors).

-- 
Meelis Roos (mroos@linux.ee)
