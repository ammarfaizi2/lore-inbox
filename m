Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313181AbSHXAeP>; Fri, 23 Aug 2002 20:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314149AbSHXAeP>; Fri, 23 Aug 2002 20:34:15 -0400
Received: from hdfdns01.hd.intel.com ([192.52.58.10]:60097 "EHLO
	mail1.hd.intel.com") by vger.kernel.org with ESMTP
	id <S313181AbSHXAeP>; Fri, 23 Aug 2002 20:34:15 -0400
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD0236DDD4@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Brueggeman, Steve'" <steve_brueggeman@xiotech.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Anyone know how to get soft-power-down to work on an Intel SC
	 B2??
Date: Fri, 23 Aug 2002 17:38:15 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ACPI: Core Subsystem version [20010615]
> ACPI: Subsystem enabled

These are the only instances of "ACPI" in the dmesg. I infer from this that
you need to include the ACPI System driver, which includes poweroff
functionality.

Regards -- Andy

PS I'm intrigued by the loopback device problem you mentioned....please let
me know if you ever figure out what caused that..:)
