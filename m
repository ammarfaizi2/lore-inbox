Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030440AbVIAWSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030440AbVIAWSM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 18:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030452AbVIAWSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 18:18:12 -0400
Received: from mail.kroah.org ([69.55.234.183]:63393 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030440AbVIAWSM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 18:18:12 -0400
Date: Thu, 1 Sep 2005 15:18:03 -0700
From: Greg KH <greg@kroah.com>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 0/7] arch: pci_find_device remove
Message-ID: <20050901221803.GA9921@kroah.com>
References: <200508292220.j7TMKbNC019793@wscnet.wsc.cz> <4317564A.4020901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4317564A.4020901@gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 09:28:10PM +0200, Jiri Slaby wrote:
> Jiri Slaby napsal(a):
> 
> >Set of patches, which removes pci_find_device from arch subtree.
> >
> >alpha/kernel/sys_alcor.c                |    3 ++-
> >alpha/kernel/sys_sio.c                  |    6 +++---
> >frv/mb93090-mb00/pci-frv.c              |    8 ++------
> >frv/mb93090-mb00/pci-irq.c              |    4 +---
> >ppc/kernel/pci.c                        |   21 +++++++++++----------
> >ppc/platforms/85xx/mpc85xx_cds_common.c |   11 +++++++----
> >sparc64/kernel/ebus.c                   |   17 ++++++-----------
> >7 files changed, 32 insertions(+), 38 deletions(-)
> > 
> >
> Ok, nobody says nothing. So against what does Greg wants patches? 
> vanilla? some git? These are against andrew's tree and it seems, that 
> greg didn't accept them.

Greg was on vacation for a week and a half, and is now traveling across
the ocean for another week, so his response time is quite slow.  But
they are in his TODO queue and will be attended to hopefully soon.

patience...

thanks,

greg k-h
