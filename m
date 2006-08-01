Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161057AbWHAFT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161057AbWHAFT0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 01:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161058AbWHAFTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 01:19:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:26066 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161057AbWHAFTY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 01:19:24 -0400
Date: Mon, 31 Jul 2006 22:14:46 -0700
From: Greg KH <greg@kroah.com>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-usb-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: usb related oops after resume
Message-ID: <20060801051446.GA23206@kroah.com>
References: <44CE96A1.2010009@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44CE96A1.2010009@gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 01:47:22AM +0159, Jiri Slaby wrote:
> Hello,
> 
> during resume I got this oops in 2.6.18-rc1-mm2 kernel:

Does the 2.6.18-rc3 kernel work properly for you?

How about a newer -mm release?

thanks,

greg k-h
