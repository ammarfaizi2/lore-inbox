Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbWCIFLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbWCIFLU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 00:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWCIFLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 00:11:20 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:44999 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750877AbWCIFLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 00:11:19 -0500
Subject: Re: State of the Linux PCI and PCI Hotplug Subsystems for
	2.6.16-rc5
From: Lee Revell <rlrevell@joe-job.com>
To: Greg KH <gregkh@suse.de>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net
In-Reply-To: <20060306223545.GA20885@kroah.com>
References: <20060306223545.GA20885@kroah.com>
Content-Type: text/plain
Date: Thu, 09 Mar 2006 00:11:16 -0500
Message-Id: <1141881077.13319.9.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-06 at 14:35 -0800, Greg KH wrote:
> List of outstanding regressions from older kernel versions:
>         - some cardbus users still have issues with the change to the
>           PCI resource allocation stuff.
>           http://bugzilla.kernel.org/show_bug.cgi?id=5736 shows this
>           issue, but seems to be stalled for now :( 

Hmm, this sounds like some recent reports on the ALSA lists, I'll ask
those users to look at this.

Lee

