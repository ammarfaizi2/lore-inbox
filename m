Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263022AbVAFSdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263022AbVAFSdm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 13:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263001AbVAFS3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 13:29:02 -0500
Received: from pop.gmx.net ([213.165.64.20]:38110 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263003AbVAFSZ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 13:25:29 -0500
Date: Thu, 6 Jan 2005 19:25:23 +0100 (MET)
From: "Daniel Kirsten" <Daniel.Kirsten@gmx.net>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <21400.1105020366@www65.gmx.net>
Subject: acpi_thermal_write_tri: Invalid argument
X-Priority: 3 (Normal)
X-Authenticated: #14521599
Message-ID: <21855.1105035923@www55.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I used 
echo -n "90:90:80:80:0" >/proc/acpi/thermal_zone/ATF0/trip_points

in rc.local.  It worked for a long time, but from 
2.6.10-rc3-mm1, I just get 

kernel: acpi_thermal-0921 [14850] acpi_thermal_write_tri: Invalid argument

Is there any documentation how to specify trip-points???

Best regards, Daniel

-- 
+++ Sparen Sie mit GMX DSL +++ http://www.gmx.net/de/go/dsl
AKTION für Wechsler: DSL-Tarife ab 3,99 EUR/Monat + Startguthaben
