Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266991AbSLPSNp>; Mon, 16 Dec 2002 13:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266996AbSLPSNp>; Mon, 16 Dec 2002 13:13:45 -0500
Received: from fmr02.intel.com ([192.55.52.25]:44785 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S266991AbSLPSNo>; Mon, 16 Dec 2002 13:13:44 -0500
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A5A4@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Pavel Machek'" <pavel@suse.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: RE: [ACPI] Metolious hardware-sensors-using-ACPI specs
Date: Mon, 16 Dec 2002 10:21:22 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Pavel Machek [mailto:pavel@suse.cz] 
> Is it goign to be implemented in linux-acpi?
> 
> I took a look at specs at intel, and it has rather funny legaleese:

Wow, is that still on a website somewhere?

So as you may know from looking at the spec, Metolious was a spec that
defined a way for platforms to enumerate various motherboard sensors to the
OS, for manageability purposes.

It never took off, except for a couple companies that used the Windows
driver for other things because they didn't want to write a driver that
received ACPI device Notify()s.

The licensing may be weird, but given that there really is no point in
implementing it on Linux, does that really matter?

Regards -- Andy
