Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268514AbRHAWea>; Wed, 1 Aug 2001 18:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268516AbRHAWeU>; Wed, 1 Aug 2001 18:34:20 -0400
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:55247 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S268514AbRHAWeD>; Wed, 1 Aug 2001 18:34:03 -0400
Message-ID: <4148FEAAD879D311AC5700A0C969E89006CDE005@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'ebuddington@wesleyan.edu'" <ebuddington@wesleyan.edu>,
        linux-kernel@vger.kernel.org
Subject: RE: 2.4.7-ac3 panic on boot (acpi?)
Date: Wed, 1 Aug 2001 15:33:50 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Would you mind doing the following:

1) Try 2.4.7 patched with the latest ACPI debug version from:

ftp://download.intel.com/technology/IAPC/acpi/downloads/acpica-linux-debug-2
0010717.tar.gz

...and send me your dmesg? We can proceed from there. ;-)

Regards -- Andy

> From: Eric Buddington 
> I began to report this bug a couple weeks back, under 
> 2.4.6-ac3, but left on vacation before
> capturing and parsing the panic.
