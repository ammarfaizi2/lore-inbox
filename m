Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbWFFG4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWFFG4u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 02:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbWFFG4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 02:56:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:18908 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750807AbWFFG4t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 02:56:49 -0400
Date: Mon, 5 Jun 2006 23:54:06 -0700
From: Greg KH <greg@kroah.com>
To: James Morris <jmorris@namei.org>
Cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: HOWTO add privileged code to the kernel without breaking LSM/SELinux
Message-ID: <20060606065406.GA17071@kroah.com>
References: <Pine.LNX.4.64.0606060229240.10150@d.namei>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606060229240.10150@d.namei>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2006 at 02:51:48AM -0400, James Morris wrote:
> 
> (CC'd GKH hoping something of this can go into his kernel hacking howto).

I always accept changes/additions to Documentation/HOWTO, feel free to
and add this there and send me a patch.  (you will probably have to
describe what MAC and DAC mean though...)

thanks,

greg k-h
