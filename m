Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261779AbVCSVBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbVCSVBW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 16:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVCSVBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 16:01:22 -0500
Received: from mail.kroah.org ([69.55.234.183]:28073 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261779AbVCSVBV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 16:01:21 -0500
Date: Sat, 19 Mar 2005 13:00:56 -0800
From: Greg KH <gregkh@suse.de>
To: Norbert Preining <preining@logic.at>
Cc: Andrew Morton <akpm@osdl.org>, Luc Saillard <luc@saillard.org>,
       linux-kernel@vger.kernel.org
Subject: Re: pwc driver in -mm kernels
Message-ID: <20050319210056.GA9171@kroah.com>
References: <20050319130424.GB3316@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050319130424.GB3316@gamma.logic.tuwien.ac.at>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 19, 2005 at 02:04:24PM +0100, Norbert Preining wrote:
> Hi Andrew, hi Luc!
> 
> I just realized that there is now the pwc driver back in -mm kernels,
> but interestingly not the one from Luc, or at least not the last
> published one (10.0.6). and wanted to ask if there is a specific reason
> for this?

Because that is the version that was submitted for inclusion.  Patches
are gladly accepted to bring the driver up to date.

thanks,

greg k-h
