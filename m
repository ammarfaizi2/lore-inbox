Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262896AbVCDM0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262896AbVCDM0S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 07:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262881AbVCDMWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 07:22:07 -0500
Received: from fire.osdl.org ([65.172.181.4]:20960 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262899AbVCDMBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 07:01:44 -0500
Date: Fri, 4 Mar 2005 04:01:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: TProvoni@aol.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Submitting a Linux Serial Driver
Message-Id: <20050304040110.480dbb96.akpm@osdl.org>
In-Reply-To: <1fb.4806775.2f599c49@aol.com>
References: <1fb.4806775.2f599c49@aol.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

TProvoni@aol.com wrote:
>
> I would like to get two new drivers incorporated into the Linux kernel.  They 
>  handle the CGI/Aurora Asynchronous only and Synch/Async serial cards.  Do I 
>  submit the kernel patches here to the linux-serial or to the linux-kernel 
>  lists?  If not here, where should I submit them.

When in doubt, use both lists.

See Documentation/SubmittingDrivers, Documentation/SubmittingPatches,
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt and
http://linux.yyz.us/patch-format.html
