Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264723AbSKMV1H>; Wed, 13 Nov 2002 16:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264739AbSKMV1H>; Wed, 13 Nov 2002 16:27:07 -0500
Received: from air-2.osdl.org ([65.172.181.6]:26042 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S264723AbSKMV0P>;
	Wed, 13 Nov 2002 16:26:15 -0500
Subject: Re: ACPI patches updated (20021111)
From: Stephen Hemminger <shemminger@osdl.org>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: acpi-devel@sourceforge.net, Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A4F9@orsmsx119.jf.intel.com>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A4F9@orsmsx119.jf.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Nov 2002 13:33:03 -0800
Message-Id: <1037223183.16635.59.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Will this fix problems with IRQ routing.
On our SMP test machines, ACPI has to be disabled otherwise the SCSI
disk controllers don't work.

This is a major pain, and ACPI should be default off until it gets
fixed.



