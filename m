Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVDNKt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVDNKt0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 06:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVDNKt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 06:49:26 -0400
Received: from verein.lst.de ([213.95.11.210]:29323 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261151AbVDNKtY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 06:49:24 -0400
Date: Thu, 14 Apr 2005 12:49:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexey Dobriyan <adobriyan@mail.ru>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org, hch@lst.de
Subject: Re: [patch 134/198] officially deprecate register_ioctl32_conversion
Message-ID: <20050414104911.GA24090@lst.de>
References: <200504121032.j3CAWlw4005676@shell0.pdx.osdl.net> <200504130202.42155.adobriyan@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504130202.42155.adobriyan@mail.ru>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 02:02:42AM +0000, Alexey Dobriyan wrote:
> 
> > +Why:	Replaced by ->compat_ioctl in file_operations and other method
> > +	vecors.
> 
> vectors ?

Yes.

