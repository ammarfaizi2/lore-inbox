Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266016AbUFDVps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266016AbUFDVps (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 17:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266017AbUFDVps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 17:45:48 -0400
Received: from fmr01.intel.com ([192.55.52.18]:19418 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S266016AbUFDVpr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 17:45:47 -0400
Subject: Re: 2.6.7-rc2-mm1 (nforce2 lockup)
From: Len Brown <len.brown@intel.com>
To: sboyce@blueyonder.co.uk
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bjorn.helgaas@hp.com>
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615FD33E@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615FD33E@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1086385540.2241.322.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 04 Jun 2004 17:45:41 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-03 at 18:04, Sid Boyce wrote:
> Reversing Bjorn's ACPI patch fixed it.

Sid,
Does it work better if you build IOAPIC support into the kernel?

Please send me the complete failing .config
and I'll try to reproduce it on my nforce2 box.

thanks,
-Len


