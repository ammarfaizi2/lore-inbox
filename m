Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262130AbUKKBkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbUKKBkm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 20:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbUKKBkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 20:40:42 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:22250 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262130AbUKKBkj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 20:40:39 -0500
Date: Wed, 10 Nov 2004 17:30:41 -0800
From: Greg KH <greg@kroah.com>
To: long <tlnguyen@snoqualmie.dp.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       ak@suse.de, akpm@osdl.org, sundarapandian.durairaj@intel.com,
       tom.l.nguyen@intel.com
Subject: Re: [PATCH] pci-mmconfig fix for 2.6.9
Message-ID: <20041111013041.GA27051@kroah.com>
References: <200411102220.iAAMKNx7030359@snoqualmie.dp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411102220.iAAMKNx7030359@snoqualmie.dp.intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2004 at 02:20:23PM -0800, long wrote:
> Here I have attached pci mmconfig fix for 2.6.9 kernel. 
> 
> This will fix the flush error in pci_mmcfg_write.

Applied, thanks.

greg k-h
