Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275041AbRIYQFW>; Tue, 25 Sep 2001 12:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275063AbRIYQFM>; Tue, 25 Sep 2001 12:05:12 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:33297 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S275041AbRIYQE7>;
	Tue, 25 Sep 2001 12:04:59 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.4.10 unresolved symbols in acpi/ospm
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 26 Sep 2001 02:05:16 +1000
Message-ID: <20049.1001433916@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_ACPI=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUSMGR=m
CONFIG_ACPI_SYS=m
CONFIG_ACPI_CPU=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_AC=m
CONFIG_ACPI_EC=m
CONFIG_ACPI_CMBATT=m
CONFIG_ACPI_THERMAL=m

depmod: *** Unresolved symbols in /lib/modules/2.4.10/kernel/drivers/acpi/ospm/thermal/ospm_thermal.o
depmod:         acpi_ut_debug_print_raw
depmod:         acpi_ut_debug_print
depmod:         acpi_ut_status_exit
depmod:         acpi_ut_exit
depmod:         acpi_ut_trace

