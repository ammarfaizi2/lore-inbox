Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274994AbRIYNPa>; Tue, 25 Sep 2001 09:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274995AbRIYNPU>; Tue, 25 Sep 2001 09:15:20 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:3345 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S274994AbRIYNPA>;
	Tue, 25 Sep 2001 09:15:00 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.4.10 acpi warnings
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 25 Sep 2001 23:15:14 +1000
Message-ID: <18980.1001423714@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Almost every ACPI file gets warnings for wbinvd.

In file included from drivers/acpi/include/platform/aclinux.h:56,
                 from drivers/acpi/include/platform/acenv.h:109,
                 from drivers/acpi/include/acpi.h:35,
                 from drivers/acpi/ospm/thermal/tzpolicy.c:38:
drivers/acpi/include/platform/acgcc.h:104: warning: `wbinvd' redefined
include/asm/system.h:128: warning: this is the location of the previous definition

