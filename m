Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318182AbSIBATY>; Sun, 1 Sep 2002 20:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318184AbSIBATY>; Sun, 1 Sep 2002 20:19:24 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:54168 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S318182AbSIBATX>; Sun, 1 Sep 2002 20:19:23 -0400
Subject: 2.5.33 - Unresolved symbols in arch/i386/kernel/apm.o - depmod:
	cpu_gdt_table
From: Miles Lane <miles.lane@attbi.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1030926996.839.338.camel@agate.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 01 Sep 2002 17:36:37 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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


#
# ACPI Support
#
CONFIG_PM=y
CONFIG_APM=m
CONFIG_APM_IGNORE_USER_SUSPEND=y
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_APM_ALLOW_INTS=y
CONFIG_APM_REAL_MODE_POWER_OFF=y


