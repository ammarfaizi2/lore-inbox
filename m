Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964910AbWE0Qgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbWE0Qgg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 12:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964911AbWE0Qgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 12:36:36 -0400
Received: from vbn.0012335.lodgenet.net ([67.96.213.158]:12229 "EHLO
	vbn.0012335.lodgenet.net") by vger.kernel.org with ESMTP
	id S964910AbWE0Qgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 12:36:36 -0400
Date: Sat, 27 May 2006 09:16:12 -0700
From: Greg KH <gregkh@suse.de>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-pci@atrey.karlin.mff.cuni.cz,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Moving pci_test_config_bits
Message-ID: <20060527161612.GA5230@suse.de>
References: <4477937F.3030802@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4477937F.3030802@garzik.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2006 at 07:47:11PM -0400, Jeff Garzik wrote:
> FYI, I plan to move pci_test_config_bits() from libata-core.c to the PCI 
> layer, where it belongs.

No objection from me.

thanks,

greg k-h
