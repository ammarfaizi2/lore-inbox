Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267629AbUHEP4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267629AbUHEP4g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 11:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267758AbUHEP4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 11:56:36 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:25535 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267629AbUHEP4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 11:56:04 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Date: Thu, 5 Aug 2004 08:54:32 -0700
User-Agent: KMail/1.6.2
Cc: Martin Mares <mj@ucw.cz>, linux-pci@atrey.karlin.mff.cuni.cz,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20040805050556.9899.qmail@web14924.mail.yahoo.com>
In-Reply-To: <20040805050556.9899.qmail@web14924.mail.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408050854.32619.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, August 4, 2004 10:05 pm, Jon Smirl wrote:
> Version 10

For some reason this version doesn't work on ia64.  It just returns bytes 
containing 0 when I try to dump the ROM.

Jesse
