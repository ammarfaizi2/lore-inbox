Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264537AbTE1FuP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 01:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbTE1FuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 01:50:15 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:1012 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP id S264537AbTE1FuO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 01:50:14 -0400
Message-ID: <3ED45130.3080304@attbi.com>
Date: Tue, 27 May 2003 23:03:28 -0700
From: Miles Lane <miles.lane@attbi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.70 -- drivers/net/irda/w83977af_ir.ko needs unknown symbol setup_dma
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: /lib/modules/2.5.70/kernel/drivers/net/irda/w83977af_ir.ko 
needs unknown symbol setup_dma
WARNING: /lib/modules/2.5.70/kernel/drivers/net/irda/ali-ircc.ko needs 
unknown symbol setup_dma
WARNING: /lib/modules/2.5.70/kernel/drivers/net/irda/nsc-ircc.ko needs 
unknown symbol setup_dma
WARNING: /lib/modules/2.5.70/kernel/drivers/net/irda/smsc-ircc2.ko needs 
unknown symbol setup_dma

CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# Platform support
#
CONFIG_PPC=y
CONFIG_PPC32=y
CONFIG_6xx=y

CONFIG_IRDA=m

#
# IrDA protocols
#
CONFIG_IRLAN=m
CONFIG_IRNET=m
CONFIG_IRCOMM=m
CONFIG_IRDA_ULTRA=y

CONFIG_IRPORT_SIR=m

#
# Old Serial dongle support
#
# CONFIG_DONGLE_OLD is not set

#
# FIR device drivers
#
CONFIG_USB_IRDA=m
CONFIG_NSC_FIR=m
CONFIG_WINBOND_FIR=m
# CONFIG_TOSHIBA_OLD is not set
CONFIG_TOSHIBA_FIR=m
# CONFIG_SMC_IRCC_OLD is not set
CONFIG_SMC_IRCC_FIR=m
CONFIG_ALI_FIR=m
CONFIG_VLSI_FIR=m

