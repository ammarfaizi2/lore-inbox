Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbUKVXNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbUKVXNU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 18:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbUKVXKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 18:10:34 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:3460 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261866AbUKVXJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 18:09:36 -0500
Date: Mon, 22 Nov 2004 15:01:28 -0800
From: Greg KH <greg@kroah.com>
To: Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC/v1][0/12] Initial submission of InfiniBand patches for review
Message-ID: <20041122230128.GA13083@kroah.com>
References: <20041122713.Nh0zRPbm8qA0VBxj@topspin.com> <20041122221304.GA15634@kroah.com> <52wtwdbiri.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52wtwdbiri.fsf@topspin.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 02:50:41PM -0800, Roland Dreier wrote:
>     Greg> Who would be including these files, only drivers in
>     Greg> drivers/infiniband?  Or from files in other parts of the
>     Greg> kernel?
> 
> In the current patchset all the code is under drivers/infiniband.

Then it should just stay in that directory.  Well, that's my preference
anyway :)

thanks,

greg k-h
