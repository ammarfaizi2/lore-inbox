Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267250AbUITTa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267250AbUITTa4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 15:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267248AbUITTa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 15:30:56 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:17924 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S267189AbUITTaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 15:30:52 -0400
Date: Mon, 20 Sep 2004 14:30:23 -0500
From: mike.miller@hp.com
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: MSI in 2.6.9-rc2-mm1 kernel
Message-ID: <20040920193023.GB5651@beardog.cca.cpqcorp.net>
Reply-To: mikem@beardog.cca.cpqcorp.net, mike.miller@hp.com
References: <C7AB9DA4D0B1F344BF2489FA165E502406610519@orsmsx404.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E502406610519@orsmsx404.amr.corp.intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2004 at 12:05:23PM -0700, Nguyen, Tom L wrote:
> 
> MSI support in 2.6.9-rc2-mm1 kernel works fine for me. It seems that you
> should check whether MSI is supported by the platform and processors of
> your system. Also, contact the vendor of your MSI device to see whether
> a device has any MSI issues, which you are not aware of.

Since you've confirmed the kernel piece works, that narrows my search.

Thanks,
mikem

> 
> Thanks,
> Long  
