Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030213AbWBHTc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbWBHTc4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 14:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbWBHTc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 14:32:56 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:41655 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932489AbWBHTcz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 14:32:55 -0500
Date: Thu, 9 Feb 2006 01:01:55 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [patch 02/03] add EXPORT_SYMBOL_GPL_FUTURE() to RCU subsystem
Message-ID: <20060208193155.GC6325@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060208184816.GA17016@kroah.com> <20060208184922.GB17016@kroah.com> <20060208185013.GC17016@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060208185013.GC17016@kroah.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 10:50:13AM -0800, Greg KH wrote:
> As the RCU symbols are going to be changed to GPL in the near future,
> let us warn users that this is going to happen.
> 
> Cc: Dipankar Sarma <dipankar@in.ibm.com>
> Cc: Paul McKenney <paul.mckenney@us.ibm.com>

Should be Paul McKenney <paulmck@us.ibm.com> for you-know-why :)

> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

Looks good. Wish we had done this much earlier to alert people.

Thanks
Dipankar
