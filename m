Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWA2VwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWA2VwQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 16:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWA2VwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 16:52:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45471 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751182AbWA2VwP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 16:52:15 -0500
Date: Sun, 29 Jan 2006 16:52:06 -0500
From: Alan Cox <alan@redhat.com>
To: Dave Jones <davej@redhat.com>, alan@redhat.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: noisy edac
Message-ID: <20060129215206.GA18670@devserv.devel.redhat.com>
References: <20060127014105.GD16422@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127014105.GD16422@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2006 at 08:41:05PM -0500, Dave Jones wrote:
> e752x_edac is very noisy on my PCIE system..
> my dmesg is filled with these...
> 
> [91671.488379] Non-Fatal Error PCI Express B
> [91671.492468] Non-Fatal Error PCI Express B
> [91901.100576] Non-Fatal Error PCI Express B
> [91901.104675] Non-Fatal Error PCI Express B

Pre-production system or final release ?

> Something need whitelisting? 

Its logging in a manner consistent with real errors so its hard to be sure
at first glance.
