Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269103AbUI2Wlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269103AbUI2Wlk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 18:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269080AbUI2Wcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 18:32:42 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:9097 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S269081AbUI2Wbo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 18:31:44 -0400
Date: Wed, 29 Sep 2004 15:32:18 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: Matthew Wilcox <matthew@wil.cx>
cc: Hanna Linder <hannal@us.ibm.com>, Greg KH <greg@kroah.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       kernel-janitors@lists.osdl.org, kraxel@bytesex.org
Subject: Re: [Kernel-janitors] Re: [PATCH 2.6.9-rc2-mm4 bttv-driver.c][4/8] convert pci_find_device to pci_dev_present
Message-ID: <21370000.1096497138@w-hlinder.beaverton.ibm.com>
In-Reply-To: <20040929222825.GK16153@parcelfarce.linux.theplanet.co.uk>
References: <15470000.1096491322@w-hlinder.beaverton.ibm.com> <20040929220344.A17872@infradead.org> <20040929211135.GA24407@kroah.com> <17920000.1096494218@w-hlinder.beaverton.ibm.com>
 <20040929222825.GK16153@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Wednesday, September 29, 2004 11:28:25 PM +0100 Matthew Wilcox <matthew@wil.cx> wrote:

> On Wed, Sep 29, 2004 at 02:43:38PM -0700, Hanna Linder wrote:
>> +	return(pci_module_init(&bttv_pci_driver));
> 
> Why the extra brackets?  I see their use for

I was already corrected offline. Greg is going to fix this before he applies it.

Thanks.

Hanna

