Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264451AbTIDBbH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 21:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264462AbTIDBbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 21:31:07 -0400
Received: from wsip-68-15-8-100.sd.sd.cox.net ([68.15.8.100]:23175 "EHLO
	gnuppy") by vger.kernel.org with ESMTP id S264451AbTIDBbF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 21:31:05 -0400
Date: Wed, 3 Sep 2003 18:30:59 -0700
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: 2.6.0-test4-mm5
Message-ID: <20030904013059.GA11791@gnuppy.monkey.org>
References: <20030902231812.03fae13f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030902231812.03fae13f.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 11:18:12PM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test4/2.6.0-test4-mm5/

make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
  CC      drivers/acpi/pci_link.o
drivers/acpi/pci_link.c: In function `acpi_pci_link_try_get_current':
drivers/acpi/pci_link.c:290: error: `_dbg' undeclared (first use in this function)
drivers/acpi/pci_link.c:290: error: (Each undeclared identifier is reported only once
drivers/acpi/pci_link.c:290: error: for each function it appears in.)
make[2]: *** [drivers/acpi/pci_link.o] Error 1
make[1]: *** [drivers/acpi] Error 2
make: *** [drivers] Error 2

------------------------------------------------------------------------------------------

bill

