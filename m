Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267540AbTBGBGu>; Thu, 6 Feb 2003 20:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267539AbTBGBGu>; Thu, 6 Feb 2003 20:06:50 -0500
Received: from fmr01.intel.com ([192.55.52.18]:27887 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267540AbTBGBGs>;
	Thu, 6 Feb 2003 20:06:48 -0500
Message-ID: <F760B14C9561B941B89469F59BA3A847138034@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: linux-kernel@vger.kernel.org
Subject: ACPI Licensing change
Date: Thu, 6 Feb 2003 17:16:12 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI

As of the next release, we will be adding the option to license the ACPI
AML interpreter (drivers/acpi/*/*.c) under the BSD license, as well as
the current, GPL license.

While this will nominally increase your rights w.r.t. the code, the real
reason for this is for us to more easily accept external contributor's
changes into the interpreter's code (a good thing for everyone).

The Linux-specific ACPI code (drivers/acpi/*.c) is not affected by this
change (i.e. it is still GPL-only).

This was mentioned a couple of months ago, but we're now finally getting
around to doing it. :)

Regards -- Andy

-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover@intel.com

