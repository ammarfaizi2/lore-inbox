Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315923AbSEZKCi>; Sun, 26 May 2002 06:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315924AbSEZKCh>; Sun, 26 May 2002 06:02:37 -0400
Received: from romulus.cs.ut.ee ([193.40.5.125]:38653 "EHLO romulus.cs.ut.ee")
	by vger.kernel.org with ESMTP id <S315923AbSEZKCh>;
	Sun, 26 May 2002 06:02:37 -0400
Date: Sun, 26 May 2002 13:02:36 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: 2.5.18 modular ACPI unresolved symbol
Message-ID: <Pine.GSO.4.43.0205261258040.23219-100000@romulus.cs.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All of ACPI is compiled as modules, depmod gives this unresolved symbol:

depmod: *** Unresolved symbols in /lib/modules/2.5.18/kernel/drivers/acpi/acpi_thermal.o
depmod: 	acpi_processor_set_thermal_limit

-- 
Meelis Roos (mroos@linux.ee)

