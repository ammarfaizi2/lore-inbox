Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422795AbWJXXDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422795AbWJXXDV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 19:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422798AbWJXXDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 19:03:21 -0400
Received: from ozlabs.org ([203.10.76.45]:6869 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1422795AbWJXXDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 19:03:20 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17726.39858.380075.856296@cargo.ozlabs.ibm.com>
Date: Wed, 25 Oct 2006 09:03:14 +1000
From: Paul Mackerras <paulus@samba.org>
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, Zhang Yanmin <yanmin.zhang@intel.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] fix building pcie portdrv_pci.c without CONFIG_PM
In-Reply-To: <200610241753.06444.arnd.bergmann@de.ibm.com>
References: <200610241753.06444.arnd.bergmann@de.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann writes:

> pcie_portdrv_restore_config is now also used outside of
> CONFIG_PM.

That's upstream already...

Paul.
