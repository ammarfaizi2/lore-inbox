Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264808AbUHCAva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264808AbUHCAva (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 20:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264782AbUHCAv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 20:51:29 -0400
Received: from mail.kroah.org ([69.55.234.183]:46565 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264858AbUHCAsH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 20:48:07 -0400
Date: Mon, 2 Aug 2004 17:43:43 -0700
From: Greg KH <greg@kroah.com>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [patchset] Lockfree fd lookup 2 of 5
Message-ID: <20040803004343.GC26323@kroah.com>
References: <20040802101053.GB4385@vitalstatistix.in.ibm.com> <20040802101604.GD4385@vitalstatistix.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802101604.GD4385@vitalstatistix.in.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2004 at 03:46:06PM +0530, Ravikiran G Thirumalai wrote:
> Here's the second patch.  This changes the current kref users to use
> the 'shrunk' kref objects and api.  GregKH has applied this to his tree too.

Well, I applied this, and then fixed it to actually link and work
properly.  Next time, please at least build your patches...

thanks,

greg k-h
