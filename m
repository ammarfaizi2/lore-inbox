Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263106AbUJ2GRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263106AbUJ2GRK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 02:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbUJ2GRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 02:17:04 -0400
Received: from mail1.kontent.de ([81.88.34.36]:55497 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S263106AbUJ2GQI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 02:16:08 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Why ACPI is in the kernel, notes from 2001
Date: Fri, 29 Oct 2004 08:16:06 +0200
User-Agent: KMail/1.6.2
Cc: "Moore, Robert" <robert.moore@intel.com>, "Theodore Ts'o" <tytso@mit.edu>,
       "Brown, Len" <len.brown@intel.com>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       "Therien, Guy" <guy.therien@intel.com>,
       "Yu, Luming" <luming.yu@intel.com>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Alex Williamson <alex.williamson@hp.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net
References: <37F890616C995246BE76B3E6B2DBE05502764E54@orsmsx403.amr.corp.intel.com> <4181C1AA.7050004@pobox.com>
In-Reply-To: <4181C1AA.7050004@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200410290816.06324.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 29. Oktober 2004 06:06 schrieb Jeff Garzik:
> None of this implies that the interpreter cannot be in initramfs-like 
> userspace, which neither requires a device driver nor will ever be paged 
> out.

Suspend/resume. User space is halted first.

	Regards
		Oliver
