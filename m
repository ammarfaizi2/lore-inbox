Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbUKPJkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbUKPJkT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 04:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbUKPJkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 04:40:19 -0500
Received: from CPE-203-51-35-114.nsw.bigpond.net.au ([203.51.35.114]:58099
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S261333AbUKPJjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 04:39:52 -0500
Message-ID: <4199CAE4.7020308@eyal.emu.id.au>
Date: Tue, 16 Nov 2004 20:39:48 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel list <linux-kernel@vger.kernel.org>
Subject: 2.6.10 ichxrom too verbose
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At boot time I get the messages below. It looks excessive to me.

Nov 16 11:06:58 eyal kernel: CFI: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: CFI: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: CFI: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: CFI: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: CFI: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: CFI: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: CFI: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: CFI: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: CFI: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: CFI: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: CFI: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: CFI: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: CFI: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: CFI: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: CFI: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: CFI: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: CFI: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: CFI: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: CFI: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: CFI: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: CFI: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: CFI: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: CFI: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: CFI: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: CFI: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: CFI: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: CFI: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: CFI: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: CFI: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: CFI: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: CFI: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: CFI: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Nov 16 11:06:58 eyal kernel: Support for command set 8007 not present
Nov 16 11:06:58 eyal kernel: Support for command set 007F not present
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 16-bit bank
Nov 16 11:06:58 eyal kernel: Support for command set 8007 not present
Nov 16 11:06:58 eyal kernel: Support for command set 007F not present
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: JEDEC: Found no ichxrom device at location zero
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Nov 16 11:06:58 eyal kernel: Support for command set 8007 not present
Nov 16 11:06:58 eyal kernel: Support for command set 007F not present
Nov 16 11:06:58 eyal kernel: gen_probe: No supported Vendor Command Set found
Nov 16 11:06:58 eyal kernel: Found: SST 49LF004B
Nov 16 11:06:58 eyal kernel: ichxrom: Found 1 x8 devices at 0x0 in 8-bit bank
Nov 16 11:06:58 eyal kernel: number of JEDEC chips: 1
Nov 16 11:06:58 eyal kernel: cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
Nov 16 11:06:58 eyal kernel: mtd: Giving out device 0 to ichxrom

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
