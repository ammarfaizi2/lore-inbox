Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270919AbRIGCoZ>; Thu, 6 Sep 2001 22:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270942AbRIGCoP>; Thu, 6 Sep 2001 22:44:15 -0400
Received: from adsl-64-171-4-169.dsl.sntc01.pacbell.net ([64.171.4.169]:21247
	"EHLO devel.office") by vger.kernel.org with ESMTP
	id <S270919AbRIGCn5>; Thu, 6 Sep 2001 22:43:57 -0400
Date: Thu, 6 Sep 2001 19:44:11 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: <christoph@devel.office>
To: <linux-kernel@vger.kernel.org>
Subject: Linux Preemptive patch success 2.4.10-pre4 + lots of other patches
Message-ID: <Pine.LNX.4.33.0109061939400.27017-100000@devel.office>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was able to run it on my laptop (compay presario) with 2.4.10-pre4 plus
kernel preemption patch plus

acpi development patches (battery status still unavailable though sigh).
tulip-0.92wax (Support for CONEXTANT onboard Ethernet)
wlan-ng 0.1.8-pre13 + airsnort patches (for SMC WiFi Card)

Seems to work very well.... Wish all the above stuff would be making it
into the kernel soon.. I keep having to patch up the kernels.

Amazing support for hardware considering I saw no support for the ACPI
stuff and the onboard ethernet when I bought the laptop....


