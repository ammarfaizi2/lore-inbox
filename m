Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319808AbSIMWH4>; Fri, 13 Sep 2002 18:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319809AbSIMWH4>; Fri, 13 Sep 2002 18:07:56 -0400
Received: from rcpt-expgw.biglobe.ne.jp ([202.225.89.153]:5250 "EHLO
	rcpt-expgw.biglobe.ne.jp") by vger.kernel.org with ESMTP
	id <S319808AbSIMWHz>; Fri, 13 Sep 2002 18:07:55 -0400
X-Biglobe-Sender: <t-kouchi@mvf.biglobe.ne.jp>
Date: Fri, 13 Sep 2002 15:13:02 -0700
From: "KOCHI, Takayoshi" <t-kouchi@mvf.biglobe.ne.jp>
To: andrew.grover@intel.com, willy@debian.org
Subject: Re: [ACPI] RE: ACPI Status
Cc: gigerstyle@gmx.ch, linux-kernel@vger.kernel.org,
       acpi-devel@sourceforge.net
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DE63@orsmsx119.jf.intel.com>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DE63@orsmsx119.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.05.04
Message-Id: <20020914071243.HARXC0A8264C.1C79D883@mvf.biglobe.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Examples of some ACPI 2.0 objects we use: XSDT, ECDT, processor performance
> state objects
> Examples of some ACPI 2.0 objects we don't use (yet): _PXM, _CST, _HPP

_HPP is already used in ACPI PCI hotplug driver.

Thanks,
-- 
KOCHI, Takayoshi <t-kouchi@cq.jp.nec.com/t-kouchi@mvf.biglobe.ne.jp>

