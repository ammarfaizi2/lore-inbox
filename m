Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136973AbREJWjY>; Thu, 10 May 2001 18:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136975AbREJWjP>; Thu, 10 May 2001 18:39:15 -0400
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:55266 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S136973AbREJWjH>; Thu, 10 May 2001 18:39:07 -0400
Message-ID: <4148FEAAD879D311AC5700A0C969E89006CDDE4D@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Mike Panetta'" <mpanetta@applianceware.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: ACPI broken in 2.4.4-ac6
Date: Thu, 10 May 2001 15:37:38 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI now has more config options. Make sure you enable bus manager and
system driver, at the very least.

Regards -- Andy

> From: Mike Panetta [mailto:mpanetta@applianceware.com]
> ACPI seems to be broken on 2.4.4-ac6 or atleast
> poweroff is broken.  During bootup all ACPI
> prints is that it was enabled, it used to
> (in plain jane 2.4.4) print the sleep levels
> supported by the bios but does not in ac6.

