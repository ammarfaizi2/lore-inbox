Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265177AbTLKRMB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 12:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265204AbTLKRMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 12:12:01 -0500
Received: from tristate.vision.ee ([194.204.30.144]:37780 "HELO mail.city.ee")
	by vger.kernel.org with SMTP id S265177AbTLKRL6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 12:11:58 -0500
From: Lenar =?ISO-8859-1?Q?L=F5hmus?= <lenar@city.ee>
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
To: linux-kernel@vger.kernel.org
Date: Thu, 11 Dec 2003 19:11:54 +0200
References: <106Zu-1sD-3@gated-at.bofh.it> <1198P-3v0-1@gated-at.bofh.it> <11gah-33u-1@gated-at.bofh.it> <11wIo-4T4-7@gated-at.bofh.it> <11xuB-6k3-11@gated-at.bofh.it> <11AC6-3Sf-3@gated-at.bofh.it>
User-Agent: KNode/0.7.6
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <20031211171154.5D240469E@xs.dev>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mptable for epox 8rda+
looks weird considering OEM&Product ID:

===============================================================================

MPTable, version 2.0.15 Linux

 looking for EBDA pointer @ 0x040e, NOT found
 searching CMOS 'top of mem' @ 0x0009f400 (637K)
 searching default 'top of mem' @ 0x0009fc00 (639K)
 searching BIOS @ 0x000f0000

 MP FPS found in BIOS @ physical addr: 0x000f5ac0

-------------------------------------------------------------------------------

MP Floating Pointer Structure:

  location:                     BIOS
  physical address:             0x000f5ac0
  signature:                    '_MP_'
  length:                       16 bytes
  version:                      1.1
  checksum:                     0x00
  mode:                         Virtual Wire

-------------------------------------------------------------------------------

MP Config Table Header:

  physical address:             0x0xf0c00
  signature:                    'M'
  base table length:            49091
  version:                      1.14
  checksum:                     0x0c
  OEM ID:                       '3ÉèoÃ
                                      '
  Product ID:                   'ÿÿPOWER ON F'
  OEM table pointer:            0x74636e75
  OEM table size:               28521
  entry count:                  8302
  local APIC address:           0x20202020
  extended table length:        8224
  extended table checksum:      32

-------------------------------------------------------------------------------

MP Config Base Table Entries:

--
MPTABLE HOSED! record type = 32

Lenar

