Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbVIBINa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbVIBINa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 04:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbVIBINa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 04:13:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:29586 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751109AbVIBIN3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 04:13:29 -0400
Date: Fri, 2 Sep 2005 01:12:52 -0700
From: Greg KH <greg@kroah.com>
To: Rajat Jain <rajat.noida.india@gmail.com>
Cc: Linux-newbie@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net,
       acpi-devel@lists.sourceforge.net, pcihpd-discuss@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org,
       dkumar@noida.hcltech.com, sanjayku@noida.hcltech.com
Subject: Re: ACPI problem with PCI Express Native Hot-plug driver
Message-ID: <20050902081252.GA11567@kroah.com>
References: <b115cb5f0509020057741365dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b115cb5f0509020057741365dc@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2005 at 04:57:33PM +0900, Rajat Jain wrote:
> Hi,
> 
> I'm using RHEL4 kernel (2.6.9), and am trying to make PCI Express
> Native Hot-plug driver (pciehp) work on my system (My system has two
> hot-pluggable PCI Express slots). I am facing following problem, and
> would really appreciate if any one can provide any info regarding this
> problem.

Can you try 2.6.13?  It is much improved in the pciehp area than 2.6.9.

thanks,

greg k-h
