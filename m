Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266582AbUG0UQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266582AbUG0UQm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 16:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266579AbUG0UQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 16:16:41 -0400
Received: from havoc.gtf.org ([216.162.42.101]:46247 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266590AbUG0UP7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 16:15:59 -0400
Date: Tue, 27 Jul 2004 16:15:57 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: "J. Ryan Earl" <heretic@clanhk.org>
Cc: Doug Maxey <dwm@austin.ibm.com>,
       Linux IDE Mailing List <linux-ide@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] IDE/ATA/SATA controller hotplug
Message-ID: <20040727201557.GA1612@havoc.gtf.org>
References: <200407191947.i6JJldK1024910@falcon10.austin.ibm.com> <41067543.3090003@pobox.com> <4106C5B7.9040606@clanhk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4106C5B7.9040606@clanhk.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2004 at 03:14:31PM -0600, J. Ryan Earl wrote:
> Jeff Garzik wrote:
> 
> >Why do you think libata is not already hotplug capable, WRT controllers?
> 
> I'm not sure what WRT means, but your last Linux SATA Update did contain:
> 
> "Hotplug support
> ---------------
> All SATA is hotplug.
> 
> libata does not support hotplug... yet.
> 
> The following SATA controllers will never support hotplug:
> Intel ICH5, Intel ICH5-R, Intel ICH6 (non-AHCI), Pacific Digital Talon,
> Promise SATA SX4."


That refers to SATA devices, not controllers.

	Jeff



