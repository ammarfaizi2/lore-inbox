Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965002AbVHYOEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbVHYOEl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 10:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbVHYOEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 10:04:41 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:45142 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S965002AbVHYOEl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 10:04:41 -0400
Date: Thu, 25 Aug 2005 16:04:37 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.13-rc7
Message-ID: <20050825140436.GA20557@harddisk-recovery.com>
References: <Pine.LNX.4.58.0508232203520.3317@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508232203520.3317@g5.osdl.org>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2005 at 10:08:13PM -0700, Linus Torvalds wrote:
>  I really wanted to release a 2.6.13, but there's been enough changes 
> while we've been waiting for other issues to resolve that I think it's 
> best to do a -rc7 first.

There's something strange going on with either ACPI or cpufreq. When
the system boots, I see that the CPU is correctly detected as a 1200
MHz mobile Athlon, but once I log in /proc/cpuinfo says it's 2.6 or 3.6
GHz CPU. I don't have the laptop with me right now, but I'll send the
boot messages tonight.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
