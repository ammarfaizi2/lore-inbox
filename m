Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUBTToq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 14:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbUBTTlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 14:41:05 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:62479 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261387AbUBTTT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 14:19:29 -0500
Date: Fri, 20 Feb 2004 19:19:27 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [PATCH] PCI update for 2.6.3
Message-ID: <20040220191927.A8816@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	pcihpd-discuss@lists.sourceforge.net
References: <10773039771460@kroah.com> <10773039773934@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <10773039773934@kroah.com>; from greg@kroah.com on Fri, Feb 20, 2004 at 11:06:18AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 20, 2004 at 11:06:18AM -0800, Greg KH wrote:
> @@ -1,5 +1,9 @@
>  /*
> - * linux/drivers/pci/msi.c
> + * File:	msi.c

Please kill these silly comments.  Everyone opening that file should
better know what he's looking at..

