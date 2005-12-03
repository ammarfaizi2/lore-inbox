Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbVLCBm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbVLCBm1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 20:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbVLCBm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 20:42:27 -0500
Received: from havoc.gtf.org ([69.61.125.42]:46496 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751140AbVLCBm0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 20:42:26 -0500
Date: Fri, 2 Dec 2005 20:42:25 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@suse.de, ak@suse.de
Subject: Re: [PATCH 0/3] x86 PCI domain support
Message-ID: <20051203014225.GA2768@havoc.gtf.org>
References: <20051203013904.GA2560@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051203013904.GA2560@havoc.gtf.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2005 at 08:39:04PM -0500, Jeff Garzik wrote:
> ACPI PCI support stopped short of supporting multiple PCI domains,
> which is something I need in order to support a current machine
> configuration, and something many will soon need, to support upcoming
> systems.

> Patches:
> 
> 1) Fix: don't hardcode PCI domain to zero
> 2) Introduce struct pci_sysdata
> 3) Add PCI domain to struct pci_sysdata


NOTE:  This should have the DO NOT APPLY label.  This is just for
comment, and testing if there are brave souls.

	Jeff



