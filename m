Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132614AbRDUN47>; Sat, 21 Apr 2001 09:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132619AbRDUN4u>; Sat, 21 Apr 2001 09:56:50 -0400
Received: from mail.mesatop.com ([208.164.122.9]:60933 "EHLO thor.mesatop.com")
	by vger.kernel.org with ESMTP id <S132614AbRDUN4l>;
	Sat, 21 Apr 2001 09:56:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: linux-kernel@vger.kernel.org
Subject: 2.4.3-ac11 request for help texts for recenty introduced config options
Date: Sat, 21 Apr 2001 07:55:44 -0600
X-Mailer: KMail [version 1.2]
Cc: esr@thyrsus.com, elenstev@mesatop.com
MIME-Version: 1.0
Message-Id: <01042107554400.01451@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As of kernel 2.4.3-ac11, there are 464 config options which have no help text in Configure.help.

Here is the list of these items which have been introduced  after 2.4.3-ac1.
Each group is incremental, versus 2.4.3-ac[n-1].

If you see one of your options here, please consider generating a patch for Configure.help,
or send me the information and I'll do the rest.

A status of "acknowledged" means that the item is being worked on by the person named or
their designate.  Thank you to the maintainers who have responded.

Thanks in advance,
Steven

2.4.3-ac11

        none

2.4.3-ac10

	CONFIG_E1355_FB_BASE
	CONFIG_E1355_REG_BASE
	CONFIG_ETRAX_CSP0_LEDS
	CONFIG_ETRAX_DEBUG_PORT0
	CONFIG_ETRAX_DEBUG_PORT1
	CONFIG_ETRAX_DEBUG_PORT2
	CONFIG_ETRAX_DEBUG_PORT3
	CONFIG_ETRAX_DEBUG_PORT_NULL
	CONFIG_ETRAX_I2C_EEPROM_16KB
	CONFIG_ETRAX_I2C_EEPROM_2KB
	CONFIG_ETRAX_I2C_EEPROM_8KB
	CONFIG_ETRAX_IDE_CSP0_8_RESET
	CONFIG_ETRAX_LED10Y
	CONFIG_ETRAX_LED11Y
	CONFIG_ETRAX_LED12R
	CONFIG_ETRAX_LED4G
	CONFIG_ETRAX_LED4R
	CONFIG_ETRAX_LED5G
	CONFIG_ETRAX_LED5R
	CONFIG_ETRAX_LED6G
	CONFIG_ETRAX_LED6R
	CONFIG_ETRAX_LED7G
	CONFIG_ETRAX_LED7R
	CONFIG_ETRAX_LED8Y
	CONFIG_ETRAX_LED9Y
	CONFIG_ETRAX_PARALLEL_PORT0
	CONFIG_ETRAX_PARALLEL_PORT1
	CONFIG_ETRAX_PARPORT
	CONFIG_ETRAX_RESCUE_SER0
	CONFIG_ETRAX_RESCUE_SER1
	CONFIG_ETRAX_RESCUE_SER2
	CONFIG_ETRAX_RESCUE_SER3
	CONFIG_ETRAX_RS485_ON_PA_BIT
	CONFIG_ETRAX_SDRAM
	CONFIG_FB_DC
	CONFIG_FB_E1355

2.4.3-ac9

        none

2.4.3-ac8

        none

2.4.3-ac7

        CONFIG_BBC_I2C

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

