Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262962AbVALAqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262962AbVALAqJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 19:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262941AbVALAn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 19:43:59 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:26242 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262973AbVALAhw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 19:37:52 -0500
Date: Tue, 11 Jan 2005 16:36:44 -0800
From: Greg KH <greg@kroah.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use modern format for PCI addresses
Message-ID: <20050112003644.GA20607@kroah.com>
References: <1105485396.31942.64.camel@eeyore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105485396.31942.64.camel@eeyore>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 04:16:36PM -0700, Bjorn Helgaas wrote:
> Use pci_name() rather than "%02x:%02x" when printing PCI
> address information.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Applied, thanks.

greg k-h
