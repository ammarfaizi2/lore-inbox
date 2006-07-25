Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbWGYUZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbWGYUZY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 16:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbWGYUZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 16:25:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:31679 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030190AbWGYUZX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 16:25:23 -0400
Date: Tue, 25 Jul 2006 13:21:01 -0700
From: Greg KH <greg@kroah.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16-stable: what's the plan?
Message-ID: <20060725202101.GA19766@kroah.com>
References: <200607251540_MC3-1-C616-72C1@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607251540_MC3-1-C616-72C1@compuserve.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 03:37:44PM -0400, Chuck Ebbert wrote:
> Any more information about how you're planning to maintain
> 2.6.16?  Has the -stable team has done their final release?

The -stable team is suffering from travel lag right now (KS, OLS, and
then OSCON), and are still working out the infrastructure issues right
now.

I think that the next .16-stable kernel will probably come from Adrian,
but need to check my patch queue before I can be sure of this.

Anyway, yes, it's still in the plans, but the conference season is
slowing things down.  It should all be in place by next week.

Thanks for your patience.

greg k-h
