Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135297AbRDLTyx>; Thu, 12 Apr 2001 15:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135298AbRDLTyp>; Thu, 12 Apr 2001 15:54:45 -0400
Received: from d247.as5200.mesatop.com ([208.164.122.247]:908 "HELO
	gopnik.dom-duraki") by vger.kernel.org with SMTP id <S135297AbRDLTyh>;
	Thu, 12 Apr 2001 15:54:37 -0400
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
Date: Thu, 12 Apr 2001 13:54:13 -0600
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Subject: Request for Configure.help entries for newly added config options.
MIME-Version: 1.0
Message-Id: <01041213541300.00836@gopnik.dom-duraki>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As of kernel 2.4.3-ac5, there are now 574 config options which have
no help text in Configure.help. I believe these are not derived options,
but setable options which could use a help entry.

Here is a list of these items which have been introduced very recently.
Each group is incremental, versus 2.4.3-ac[n-1].

Of course, there are 548 other options which also should have texts.

If you see one of your options here, please consider generating a patch
for Configure.help, or send me the information and I'll do the rest.

Thanks,
Steven

2.4.3-ac5

        CONFIG_IA64_EFIVARS
        CONFIG_ITANIUM
        CONFIG_MCKINLEY
        CONFIG_MCKINLEY_A0_SPECIFIC
        CONFIG_MCKINLEY_ASTEP_SPECIFIC

2.4.3-ac4

        CONFIG_ARCH_CLPS711X
        CONFIG_ARCH_P720T
        CONFIG_ARM_THUMB
        CONFIG_CPU_ARM1020
        CONFIG_CPU_ARM610
        CONFIG_CPU_ARM710
        CONFIG_CPU_ARM720T
        CONFIG_CPU_ARM920T
        CONFIG_CPU_SA110
        CONFIG_DASD_DIAG
        CONFIG_DEBUG_CLPS711X_UART2
        CONFIG_DEBUGSYM
        CONFIG_GCOV
        CONFIG_GPROF
        CONFIG_HOSTFS
        CONFIG_NET_UM_ETH
        CONFIG_NET_UMN
        CONFIG_SA1100_PANGOLIN
        CONFIG_SA1100_SHERMAN
        CONFIG_SSL

2.4.3-ac3

        none

2.4.3-ac2

        CONFIG_GEMINI
