Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264358AbUENLDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbUENLDq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 07:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265192AbUENLDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 07:03:46 -0400
Received: from mail.kroah.org ([65.200.24.183]:48770 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264358AbUENLDp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 07:03:45 -0400
Date: Fri, 14 May 2004 04:03:01 -0700
From: Greg KH <greg@kroah.com>
To: Alberto Bertogli <albertogli@telpin.com.ar>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: BUG when removing USB flash drive
Message-ID: <20040514110301.GB29423@kroah.com>
References: <20040514004132.GA10537@telpin.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040514004132.GA10537@telpin.com.ar>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2004 at 09:41:32PM -0300, Alberto Bertogli wrote:
> 
> This is a stock 2.6.6 kernel, on a Pentium 4 with HT (the kernel is
> compiled with both SMP and preempt).

Can you test the latest -mm tree and see if it fixes this problem for
you?

thanks,

greg k-h
