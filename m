Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbVCHWgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVCHWgT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 17:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVCHWgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 17:36:18 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:44505 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261369AbVCHWdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 17:33:55 -0500
Date: Tue, 8 Mar 2005 22:33:53 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] resync ATI PCI idents into base kernel
Message-ID: <20050308223353.GA19278@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200503072216.j27MGxtP024504@hera.kernel.org> <20050308053941.GA16450@kroah.com> <1110276929.28860.93.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110276929.28860.93.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2005 at 10:15:30AM +0000, Alan Cox wrote:
> > Was there a reason you did this without using tabs, like the rest of the
> > file?
> 
> No but I'll send Linus an update to fix that now.
> 
> > Again, the maintainer chain is well documented...
> 
> Really - so does it go to the PCI maintainer, the IDE maintainer or the
> DRI maintainer or someone else, or all of them, or in bits to different
> ones remembering there are dependancies and I don't use bitcreeper ?

If you don't know send it to Andrew.  

