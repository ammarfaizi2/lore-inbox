Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266520AbSLDMlF>; Wed, 4 Dec 2002 07:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266527AbSLDMlF>; Wed, 4 Dec 2002 07:41:05 -0500
Received: from nimbus19.internetters.co.uk ([209.61.216.65]:27815 "HELO
	nimbus19.internetters.co.uk") by vger.kernel.org with SMTP
	id <S266520AbSLDMlE>; Wed, 4 Dec 2002 07:41:04 -0500
Subject: Ctrl-Alt-Backspace kills machine not X. ACPI?
From: Alex Bennee <alex@braddahead.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8-3mdk 
Date: 04 Dec 2002 12:45:45 +0000
Message-Id: <1039005946.2366.25.camel@cambridge.braddahead>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been running into problems with my machine locking up in X but
however I have been unable to diagnose it because the Ctrl-Alt-Backspace
key sequence kills my whole machine (i.e. powers it down).

I've done some searching on google but haven't been able to find any
references except a one errata note for Mandrake that mentions disabling
the APIC which I tried and had no effect.

The Ctrl-Alt-Backspace sequence will power down my machine at any point
(BIOS Self-test, Grub, Console mode or X) but doesn't to it once Windows
is running. I have a suspicion that this is ACPI related but even with
acpi=off and apm=off flags is can still stop the box which can't be
right. Any pointers? I stand ready to provide any additional data.

-- 
Alex Bennee
Senior Hacker, Braddahead Ltd
The above is probably my personal opinion and may not be that of my
employer

