Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265401AbUAJUUl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 15:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265393AbUAJUUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 15:20:41 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:55231 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265401AbUAJUU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 15:20:26 -0500
Date: Sat, 10 Jan 2004 15:20:25 -0500
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problems with CONFIG_PCI_USE_VECTOR in 2.6.1
Message-ID: <20040110202025.GA1406@localhost>
References: <7F740D512C7C1046AB53446D3720017361881E@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7F740D512C7C1046AB53446D3720017361881E@scsmsx402.sc.intel.com>
User-Agent: Mutt/1.5.4i
From: "Eric C. Cooper" <ecc@cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 10, 2004 at 07:36:23AM -0800, Nakajima, Jun wrote:
> 1. Can please you check what happens if you boot the kernel with ACPI
> disabled, i.e. use the boot parameter "acpi=off" or "pci=noacpi"? 
> 
> 2. Do you see the same ACPI complaints when you boot the kernel without
> CONFIG_PCI_USE_VECTOR configured?

There are no problems in either of these two cases; the system works fine.

-- 
Eric C. Cooper          e c c @ c m u . e d u
