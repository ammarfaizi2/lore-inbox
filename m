Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262545AbUKEIxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262545AbUKEIxS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 03:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262627AbUKEIxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 03:53:17 -0500
Received: from mail.kroah.org ([69.55.234.183]:16612 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262545AbUKEIxP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 03:53:15 -0500
Date: Fri, 5 Nov 2004 00:50:03 -0800
From: Greg KH <greg@kroah.com>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] randomized major and minor numbers
Message-ID: <20041105085003.GA26457@kroah.com>
References: <418A36CD.2030600@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418A36CD.2030600@gmx.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 03:03:57PM +0100, Carl-Daniel Hailfinger wrote:
> Hi,
> 
> IIRC it was debated during 2.5 development to make the kernel
> hand out randomized major/minor numbers to better test handling
> of dynamic major/minor numbers. Is there a patch available
> to test?

Not yet, care to make one?  :)

Note, any such change, would only be a development aid, and not a
requirement by any means.

thanks,

greg k-h
