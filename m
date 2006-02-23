Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751626AbWBWA7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbWBWA7q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 19:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbWBWA7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 19:59:46 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63907 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751470AbWBWA7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 19:59:45 -0500
Date: Wed, 22 Feb 2006 17:01:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: maule@sgi.com, linuxppc64-dev@ozlabs.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, tony.luck@intel.com, gregkh@suse.de
Subject: Re: Altix SN2 2.6.16-rc1-mm5 build breakage (was:  msi support)
Message-Id: <20060222170142.497eaac3.akpm@osdl.org>
In-Reply-To: <20060222165009.6493e6a1.pj@sgi.com>
References: <20060119194647.12213.44658.14543@lnx-maule.americas.sgi.com>
	<20060119194702.12213.16524.93275@lnx-maule.americas.sgi.com>
	<20060203201441.194be500.pj@sgi.com>
	<20060203202531.27d685fa.akpm@osdl.org>
	<20060203202742.1e514fcc.akpm@osdl.org>
	<20060222165009.6493e6a1.pj@sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> Your broken-out/series file (2.6.16-rc4-mm1) has the lines:
> 
>     # Need this when gregkh-pci-altix-msi-support.patch comes back
>     #gregkh-pci-altix-msi-support-git-ia64-fix.patch

Bah.   I resurrected it, thanks.
