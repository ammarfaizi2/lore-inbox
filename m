Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263501AbUCPIAL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 03:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263506AbUCPIAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 03:00:11 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:5136 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263501AbUCPIAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 03:00:02 -0500
Date: Tue, 16 Mar 2004 07:04:09 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Driver Core update for 2.6.4
Message-ID: <20040316070409.A28022@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <10793951494179@kroah.com> <1079395149503@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1079395149503@kroah.com>; from greg@kroah.com on Mon, Mar 15, 2004 at 03:59:09PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2004 at 03:59:09PM -0800, Greg KH wrote:
> ChangeSet 1.1608.84.16, 2004/03/15 14:39:18-08:00, greg@kroah.com
> 
> kref: add kref structure to kernel tree.
> 
> Based on the kobject structure, but much smaller and simpler to use.

Didn't everyone who reviewed this say it's useless bloat.  Andi even got
so far as calling it obsfucation, given that hides simple things behind
an overly complex and wastefull abstraction.

