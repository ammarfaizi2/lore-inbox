Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265105AbUBATtc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 14:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265415AbUBATtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 14:49:32 -0500
Received: from fmr03.intel.com ([143.183.121.5]:39657 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S265105AbUBATtb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 14:49:31 -0500
Subject: Re: oops with 2.6.1-rc1 and rc-3
From: Len Brown <len.brown@intel.com>
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: Micha Feigin <michf@post.tau.ac.il>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0020AEB18@hdsmsx402.hd.intel.com>
References: <BF1FE1855350A0479097B3A0D2A80EE0020AEB18@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1075664953.2389.12.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 01 Feb 2004 14:49:13 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-02-01 at 05:36, Prakash K. Cheemplavam wrote:

> So there seems to be some serious issue since 2.6.2-rc2 going on.
> Maybe
> some ACPI related update?

If you find that it goes away when you boot with pci=noacpi, or
acpi=off, then it is likely an ACPI issue -- otherwise it is likely
something else -- so give those a try and let me know.

thanks,
-Len


