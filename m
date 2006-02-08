Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbWBHTkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWBHTkf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 14:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbWBHTkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 14:40:35 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:12203
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932391AbWBHTke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 14:40:34 -0500
Date: Wed, 8 Feb 2006 11:40:25 -0800
From: Greg KH <gregkh@suse.de>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [patch 02/03] add EXPORT_SYMBOL_GPL_FUTURE() to RCU subsystem
Message-ID: <20060208194025.GA25295@suse.de>
References: <20060208184816.GA17016@kroah.com> <20060208184922.GB17016@kroah.com> <20060208185013.GC17016@kroah.com> <20060208193155.GC6325@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060208193155.GC6325@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2006 at 01:01:55AM +0530, Dipankar Sarma wrote:
> On Wed, Feb 08, 2006 at 10:50:13AM -0800, Greg KH wrote:
> > As the RCU symbols are going to be changed to GPL in the near future,
> > let us warn users that this is going to happen.
> > 
> > Cc: Dipankar Sarma <dipankar@in.ibm.com>
> > Cc: Paul McKenney <paul.mckenney@us.ibm.com>
> 
> Should be Paul McKenney <paulmck@us.ibm.com> for you-know-why :)

Then you might want to consider changing the in-kernel comments where
this address is :)

> > Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> Looks good. Wish we had done this much earlier to alert people.

Glad you like it.

thanks,

greg k-h
