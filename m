Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbUDAH07 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 02:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262752AbUDAH07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 02:26:59 -0500
Received: from mail.kroah.org ([65.200.24.183]:40145 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262758AbUDAH0z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 02:26:55 -0500
Date: Wed, 31 Mar 2004 23:24:59 -0800
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@osdl.org>, maneesh@in.ibm.com, david-b@pacbell.net,
       viro@math.psu.edu, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Unregistering interfaces
Message-ID: <20040401072459.GG13028@kroah.com>
References: <20040331003327.GB10262@kroah.com> <Pine.LNX.4.44L0.0403311035130.1752-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0403311035130.1752-100000@ida.rowland.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2004 at 10:54:17AM -0500, Alan Stern wrote:
> Here's a suggestion for a correct solution.  It's a little bit awkward,
> but less so than other ideas I've heard.

<snip>

> If you think this sounds good, I will start working on it.

Yes, this sounds like an excellent way of doing this, and is what I was
mulling over today in between doing real work :)

It would be great if you want to work on this, and have the time to.
Feel free to post incremental changes, and if you need any other help
with this.

thanks for volunteering.

greg k-h
