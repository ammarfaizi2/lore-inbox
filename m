Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318133AbSIAWSZ>; Sun, 1 Sep 2002 18:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318141AbSIAWSZ>; Sun, 1 Sep 2002 18:18:25 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:25796 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S318133AbSIAWSY>; Sun, 1 Sep 2002 18:18:24 -0400
Subject: 2.5.33 -- Unresolved symbols in acpi/ac.o: acpi_ut_debug_print,
	acpi_ut_value_exit, acpi_ut_exit, acpi_ut_trace
From: Miles Lane <miles.lane@attbi.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1030920114.874.329.camel@agate.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 01 Sep 2002 15:41:58 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# General setup
#
CONFIG_NET=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_M686=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_P4THERMAL=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y

CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_DEBUG=y
CONFIG_PM=y


depmod: *** Unresolved symbols in
/lib/modules/2.5.33/kernel/drivers/acpi/ac.o
depmod: 	acpi_ut_debug_print
depmod: 	acpi_ut_value_exit
depmod: 	acpi_ut_exit
depmod: 	acpi_ut_trace
depmod: *** Unresolved symbols in
/lib/modules/2.5.33/kernel/drivers/acpi/battery.o
depmod: 	acpi_ut_debug_print
depmod: 	acpi_ut_value_exit
depmod: 	acpi_ut_exit
depmod: 	acpi_ut_trace
depmod: *** Unresolved symbols in
/lib/modules/2.5.33/kernel/drivers/acpi/button.o
depmod: 	acpi_ut_debug_print
depmod: 	acpi_ut_value_exit
depmod: 	acpi_ut_status_exit
depmod: 	acpi_ut_exit
depmod: 	acpi_ut_trace
depmod: *** Unresolved symbols in
/lib/modules/2.5.33/kernel/drivers/acpi/fan.o
depmod: 	acpi_ut_debug_print
depmod: 	acpi_ut_value_exit
depmod: 	acpi_ut_exit
depmod: 	acpi_ut_trace
depmod: *** Unresolved symbols in
/lib/modules/2.5.33/kernel/drivers/acpi/processor.o
depmod: 	acpi_ut_debug_print
depmod: 	acpi_ut_value_exit
depmod: 	acpi_ut_exit
depmod: 	acpi_ut_trace
depmod: *** Unresolved symbols in
/lib/modules/2.5.33/kernel/drivers/acpi/thermal.o
depmod: 	acpi_ut_debug_print
depmod: 	acpi_ut_value_exit
depmod: 	acpi_ut_exit
depmod: 	acpi_ut_trace


