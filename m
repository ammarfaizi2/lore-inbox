Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265132AbTARWKY>; Sat, 18 Jan 2003 17:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265139AbTARWKX>; Sat, 18 Jan 2003 17:10:23 -0500
Received: from [195.39.17.254] ([195.39.17.254]:7172 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S265132AbTARWJs>;
	Sat, 18 Jan 2003 17:09:48 -0500
Date: Sat, 18 Jan 2003 22:31:34 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Andrew Grover <andrew.grover@intel.com>
Subject: Code obfuscation in acpi
Message-ID: <20030118213134.GA8968@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


#define acpi_driver_data(d)     ((d)->driver_data)

... very nice for obfuscating code ...
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
