Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132482AbRDNRZq>; Sat, 14 Apr 2001 13:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132483AbRDNRZg>; Sat, 14 Apr 2001 13:25:36 -0400
Received: from d215.as5200.mesatop.com ([208.164.122.215]:24456 "HELO
	gopnik.dom-duraki") by vger.kernel.org with SMTP id <S132482AbRDNRZ1>;
	Sat, 14 Apr 2001 13:25:27 -0400
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
Date: Sat, 14 Apr 2001 11:24:54 -0600
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Subject: 2.4.3-ac6 config options with no Configure.help text.
MIME-Version: 1.0
Message-Id: <01041411245400.00878@gopnik.dom-duraki>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As of kernel 2.4.3-ac6, there are 575 config options which have no help text in Configure.help.

Here is a list of these items which have been introduced recently, after 2.4.3-ac1.

Each group is incremental, versus 2.4.3-ac[n-1].

If you see one of your options here, please consider generating a patch for Configure.help,
or send me the information and I'll do the rest.

A status of "acknowledged" means that the item is being worked on by the person named or
their designate or the patch has been submitted but hasn't yet appeared in an -ac release.  

Thank you to the maintainers who have responded.

Thanks in advance,
Steven

2.4.3-ac6

        CONFIG_AIC7XXX_BUILD_FIRMWARE

2.4.3-ac5

        CONFIG_IA64_EFIVARS                             acknowledged    Matt Domsch
        CONFIG_ITANIUM
        CONFIG_MCKINLEY
        CONFIG_MCKINLEY_A0_SPECIFIC
        CONFIG_MCKINLEY_ASTEP_SPECIFIC

2.4.3-ac4

        CONFIG_ARCH_CLPS711X
        CONFIG_ARCH_P720T
        CONFIG_ARM_THUMB
        CONFIG_CPU_ARM1020
        CONFIG_CPU_ARM610                               acknowledged    Russell King
        CONFIG_CPU_ARM710                               acknowledged    Russell King
        CONFIG_CPU_ARM720T                              acknowledged    Russell King
        CONFIG_CPU_ARM920T                              acknowledged    Russell King
        CONFIG_CPU_SA110                                acknowledged    Russell King
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
