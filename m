Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268257AbUHQOvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268257AbUHQOvW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 10:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268283AbUHQOvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 10:51:21 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:59617 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S268282AbUHQOsp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 10:48:45 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Shawn Starr <shawn.starr@rogers.com>
Subject: Re: 2.6.8.1-mm1 broke USB driver with ACPI pci irq routing... info follows
Date: Tue, 17 Aug 2004 08:48:41 -0600
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200408170257.26712.shawn.starr@rogers.com>
In-Reply-To: <200408170257.26712.shawn.starr@rogers.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408170848.42173.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 August 2004 12:57 am, Shawn Starr wrote:
> here is the lspci info. If I enable pci=routeirq the driver loads fine.

Thanks!  Could I trouble you to also send the full dmesg logs?  If
you can get one from the failing case as well, that'd be great (but
it might require a serial console; not sure exactly where the failure
you're seeing is).
