Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293461AbSCUMgD>; Thu, 21 Mar 2002 07:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293668AbSCUMfx>; Thu, 21 Mar 2002 07:35:53 -0500
Received: from [195.39.17.254] ([195.39.17.254]:20611 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S293461AbSCUMfo>;
	Thu, 21 Mar 2002 07:35:44 -0500
Date: Thu, 21 Mar 2002 13:33:57 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: device.h: typo fix
Message-ID: <20020321123356.GA22872@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Please apply (to 2.5.7 only, probably).
								Pavel

--- clean/include/linux/device.h	Tue Mar  5 21:52:49 2002
+++ linux-acpi/include/linux/device.h	Thu Mar 21 13:19:25 2002
@@ -83,7 +84,7 @@
 					   device */
 	void		*driver_data;	/* data private to the driver */
 	void		*platform_data;	/* Platform specific data (e.g. ACPI,
-					   BIOS data relevant to device */
+					   BIOS data relevant to device) */
 
 	u32		current_state;  /* Current operating state. In
 					   ACPI-speak, this is D0-D3, D0

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
