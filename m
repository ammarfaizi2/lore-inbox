Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262606AbULRFwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbULRFwu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 00:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262839AbULRFwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 00:52:50 -0500
Received: from [66.35.79.110] ([66.35.79.110]:49634 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S262606AbULRFwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 00:52:49 -0500
Date: Fri, 17 Dec 2004 21:49:33 -0800
From: Tim Hockin <thockin@hockin.org>
To: Greg KH <greg@kroah.com>
Cc: "Nguyen, Tom L" <tom.l.nguyen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]PCI Express Port Bus Driver
Message-ID: <20041218054933.GA11423@hockin.org>
References: <C7AB9DA4D0B1F344BF2489FA165E5024073EBAE0@orsmsx404.amr.corp.intel.com> <20041218000531.GC24586@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041218000531.GC24586@kroah.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2004 at 04:05:31PM -0800, Greg KH wrote:
> Hm, I get a oops message at boot time, on a non-pci express box, with
> PCI_GOMMCONFIG enabled and your patch.  Something down in the ACPI
> subsystem. 

Speaking of this - does anyone have a pointer to the ACPI MCFG table
format spec?  I can't find it on PCI SIG.

Tim
