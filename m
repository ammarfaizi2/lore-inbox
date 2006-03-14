Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751924AbWCNT2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924AbWCNT2a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 14:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbWCNT2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 14:28:30 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:37328
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751924AbWCNT2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 14:28:30 -0500
Date: Tue, 14 Mar 2006 11:28:24 -0800
From: Greg KH <greg@kroah.com>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [Patch 0/9] Per-task delay accounting
Message-ID: <20060314192824.GB27012@kroah.com>
References: <1142296834.5858.3.camel@elinux04.optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142296834.5858.3.camel@elinux04.optonline.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2006 at 07:40:34PM -0500, Shailabh Nagar wrote:
> This is the next iteration of the delay accounting patches
> last posted at
> 	http://www.ussg.iu.edu/hypermail/linux/kernel/0602.3/0893.html

Do you have any benchmark numbers with this patch applied and with it
not applied?  Last I heard it was a measurable decrease for some
"important" benchmark results...

thanks,

greg k-h
