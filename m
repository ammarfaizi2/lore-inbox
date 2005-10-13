Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbVJMBck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbVJMBck (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 21:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbVJMBck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 21:32:40 -0400
Received: from mail.kroah.org ([69.55.234.183]:35305 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932278AbVJMBck (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 21:32:40 -0400
Date: Wed, 12 Oct 2005 18:14:51 -0700
From: Greg KH <greg@kroah.com>
To: Mark Gross <mgross@linux.intel.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Sebastien.Bouchard@ca.kontron.com, mark.gross@intel.com
Subject: Re: Fwd: Telecom Clock Driver for MPCBL0010 ATCA computer blade
Message-ID: <20051013011451.GA28844@kroah.com>
References: <200510060803.21470.mgross@linux.intel.com> <200510121530.00997.mgross@linux.intel.com> <20051012224919.GA1730@kroah.com> <200510121636.29821.mgross@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510121636.29821.mgross@linux.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2005 at 04:36:29PM -0700, Mark Gross wrote:
> No, but I'm glad I tested that otherwise the my problem with using dev_dbg 
> with the kobj->dev devices I got from the misc_device class could have gotten 
> by me.

Yeah, it's always good to test the code to make sure it compiles :)

This patch looks good, I have no objections to it.

thanks,

greg k-h
