Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268576AbRHAWlA>; Wed, 1 Aug 2001 18:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268562AbRHAWku>; Wed, 1 Aug 2001 18:40:50 -0400
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:40403 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S268573AbRHAWkn>; Wed, 1 Aug 2001 18:40:43 -0400
Message-ID: <4148FEAAD879D311AC5700A0C969E89006CDE006@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "Acpi-linux (E-mail)" <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: RFC: moving ACPI includes under include/
Date: Wed, 1 Aug 2001 15:40:48 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ACPI driver currently has its own little include directory under
drivers/acpi.

...thinking about moving these to include/acpi -- that seems to be the
dominant Linux paradigm. Sound reasonable?

Regards -- Andy

PS general ACPI flames >/dev/null

----------------------------
Andrew Grover
Intel/TRL/Mobile Arch Lab
andrew.grover@intel.com

