Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267252AbSKPJcf>; Sat, 16 Nov 2002 04:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267253AbSKPJce>; Sat, 16 Nov 2002 04:32:34 -0500
Received: from mailhost2-bcvloh.bcvloh.ameritech.net ([66.73.20.44]:48014 "EHLO
	mailhost.bcv2.ameritech.net") by vger.kernel.org with ESMTP
	id <S267252AbSKPJcd>; Sat, 16 Nov 2002 04:32:33 -0500
Message-ID: <3DD61263.30009@ameritech.net>
Date: Sat, 16 Nov 2002 03:39:47 -0600
From: watermodem <aquamodem@ameritech.net>
Reply-To: aquamodem@ameritech.net
Organization: not at all
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel 2.4.20-rc2 compiler warning for hpusbscsi module (__FUNCTION__)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hpusbscsi.c: In function `hpusbscsi_usb_probe':
hpusbscsi.c:121: warning: concatenation of string literals with 
__FUNCTION__ is deprecated
hpusbscsi.c: In function `hpusbscsi_init':
hpusbscsi.c:246: warning: concatenation of string literals with 
__FUNCTION__ is deprecated
hpusbscsi.c: In function `hpusbscsi_scsi_queuecommand':
hpusbscsi.c:379: warning: concatenation of string literals with 
__FUNCTION__ is deprecated
hpusbscsi.c:389: warning: concatenation of string literals with 
__FUNCTION__ is deprecated
hpusbscsi.c:413: warning: concatenation of string literals with 
__FUNCTION__ is deprecated
hpusbscsi.c: In function `hpusbscsi_scsi_host_reset':
hpusbscsi.c:428: warning: concatenation of string literals with 
__FUNCTION__ is deprecated
hpusbscsi.c: In function `hpusbscsi_scsi_abort':
hpusbscsi.c:439: warning: concatenation of string literals with 
__FUNCTION__ is deprecated
hpusbscsi.c: In function `control_interrupt_callback':
hpusbscsi.c:466: warning: concatenation of string literals with 
__FUNCTION__ is deprecated
hpusbscsi.c:492: warning: concatenation of string literals with 
__FUNCTION__ is deprecated
hpusbscsi.c:496: warning: concatenation of string literals with 
__FUNCTION__ is deprecated
hpusbscsi.c:501: warning: concatenation of string literals with 
__FUNCTION__ is deprecated
hpusbscsi.c:507: warning: concatenation of string literals with 
__FUNCTION__ is deprecated
hpusbscsi.c:509: warning: concatenation of string literals with 
__FUNCTION__ is deprecated
hpusbscsi.c: In function `simple_command_callback':
hpusbscsi.c:521: warning: concatenation of string literals with 
__FUNCTION__ is deprecated
hpusbscsi.c:523: warning: concatenation of string literals with 
__FUNCTION__ is deprecated
hpusbscsi.c:529: warning: concatenation of string literals with 
__FUNCTION__ is deprecated
hpusbscsi.c: In function `scatter_gather_callback':
hpusbscsi.c:540: warning: concatenation of string literals with 
__FUNCTION__ is deprecated
hpusbscsi.c:551: warning: concatenation of string literals with 
__FUNCTION__ is deprecated
hpusbscsi.c:554: warning: concatenation of string literals with 
__FUNCTION__ is deprecated
hpusbscsi.c:569: warning: concatenation of string literals with 
__FUNCTION__ is deprecated
hpusbscsi.c: In function `simple_done':
hpusbscsi.c:580: warning: concatenation of string literals with 
__FUNCTION__ is deprecated
hpusbscsi.c:581: warning: concatenation of string literals with 
__FUNCTION__ is deprecated
hpusbscsi.c:591: warning: concatenation of string literals with 
__FUNCTION__ is deprecated
hpusbscsi.c: In function `simple_payload_callback':
hpusbscsi.c:625: warning: concatenation of string literals with 
__FUNCTION__ is deprecated
hpusbscsi.c:628: warning: concatenation of string literals with 
__FUNCTION__ is deprecated
make -C storage modules
make[3]: Entering directory `/usr/src/linux-2.4.20-rc2/drivers/usb/storage'

