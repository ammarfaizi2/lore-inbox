Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932754AbWCVV0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932754AbWCVV0V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 16:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932756AbWCVV0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 16:26:21 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:27545 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932754AbWCVV0U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 16:26:20 -0500
Date: Wed, 22 Mar 2006 20:59:10 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Arjan van de Ven <arjan@infradead.org>, minyard@acm.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Yani Ioannou <yani.ioannou@gmail.com>
Subject: Re: [PATCH 2/2] Add full sysfs support to the IPMI driver
Message-ID: <20060322205910.GL27946@ftp.linux.org.uk>
References: <20060321221328.GB27436@i2.minyard.local> <1143018069.2955.43.camel@laptopd505.fenrus.org> <20060322204751.GC12335@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060322204751.GC12335@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2006 at 12:47:51PM -0800, Greg KH wrote:
> Of course that's not ok.
> 
> Come on people, does everyone think I just put that warning message in
> the kernel for fun to force you to create an empty release function?
> Why do people ignore the helpful hints that the kernel provides?
> 
> I can take that check out and watch people get their code wrong even
> more, as it sure doesn't seem like it is helping anyone out these
> days...

Put a description on sufficiently stable site and make that
	printk(KERN_ERR "Read The Fucking Manual, wanker: %s\n", URL);

