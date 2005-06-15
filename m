Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbVFOAPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbVFOAPl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 20:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVFOAPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 20:15:40 -0400
Received: from mail.kroah.org ([69.55.234.183]:6530 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261439AbVFOAPe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 20:15:34 -0400
Date: Tue, 14 Jun 2005 17:15:28 -0700
From: Greg KH <greg@kroah.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: sysfs panic from 2.6.11
Message-ID: <20050615001528.GA21523@kroah.com>
References: <23990000.1118794332@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23990000.1118794332@[10.10.2.4]>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2005 at 05:12:12PM -0700, Martin J. Bligh wrote:
> Is this a known issue that's fixed in later releases? I don't remember it
> from earlier tests ... during boot on a NUMA-Q
> 
> Mapping cpu 0 to node 0
> Brought up 1 CPUs
> NET: Registered protocol family 16
> PCI: Using configuration type 1
> mtrr: v2.0 (20020519)
> SCSI subsystem initialized
> PCI: Probing PCI hardware (bus 00)
> PCI: Searching for i450NX host bridges on 0000:00:10.0
> PCI: Searching for i450NX host bridges on 0000:01:10.0

Hm, I don't remember this being a problem before.  Does it also happen
on 2.6.12-rc6?

thanks,

greg k-h
