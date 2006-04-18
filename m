Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbWDRQJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbWDRQJE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 12:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWDRQJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 12:09:04 -0400
Received: from cantor2.suse.de ([195.135.220.15]:4819 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751070AbWDRQJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 12:09:01 -0400
Date: Tue, 18 Apr 2006 09:07:50 -0700
From: Greg KH <greg@kroah.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: "Kazuki Omo(Company)" <k-omo@10art-ni.co.jp>,
       Stephen Smalley <sds@tycho.nsa.gov>,
       linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>,
       linux-kernel@vger.kernel.org, fireflier-devel@lists.sourceforge.net
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
Message-ID: <20060418160750.GA31225@kroah.com>
References: <20060418144513.GA29780@kroah.com> <20060418155148.27641.qmail@web36609.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060418155148.27641.qmail@web36609.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2006 at 08:51:47AM -0700, Casey Schaufler wrote:
> 
> --- Greg KH <greg@kroah.com> wrote:
> 
> 
> > That's great.  But why haven't you submitted LIDS
> > for acceptance into the main kernel tree?
> 
> Perhaps a pointer to instructions on how
> one might go about doing so would be helpful.

Documentation/SubmittingPatches is almost everything you need to know on
how to submit a patch for inclusion in the kernel source tree.
Documentation/HOWTO is also a good place to start with, as it has a few
pointers to other locations in the Documentation tree, and on the web,
for things to read on how to do this.

Hope this helps,

greg k-h
