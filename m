Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262996AbTHVCoK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 22:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262997AbTHVCoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 22:44:10 -0400
Received: from EPRONET.01.dios.net ([65.222.230.105]:23968 "EHLO
	mail.eproinet.com") by vger.kernel.org with ESMTP id S262996AbTHVCoH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 22:44:07 -0400
Date: Thu, 21 Aug 2003 22:11:00 -0400 (EDT)
From: "Mark W. Alexander" <slash@dotnetslash.net>
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: [SOLVED] RE: 2.6.0-test3 latest bk hangs when enabling IO-APIC
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE009FC78@hdsmsx402.hd.intel.com>
Message-ID: <Pine.LNX.4.44.0308212205380.1824-100000@llave.eproinet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Aug 2003, Brown, Len wrote:

> CONFIG_ACPI_HT is mostly just an alias for CONFIG_ACPI_BOOT -- the early
> boot part of ACPI without the run-time events included in the full ACPI
> implementation.  Unless I screwed up the config dependencies, it should
> be impossible to enable the full CONFIG_ACPI without including
> CONFIG_ACPI_HT.

Then one of us screwed up. I've configured everything ACPI I could
find via gconf and there's no sign on CONFIG_ACPI_HT on my .config. I
_do_ have CONFIG_ACPI_BOOT, though, so what to you mean by "mostly"
just an alias.

(And please be gentle, I'm just figuring out ACPI out of necessity
since my new HP ze4400 barely has a BIOS, let alone APM ;)

mwa
-- 
Mark W. Alexander
slash@dotnetslash.net

