Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWDROqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWDROqp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 10:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWDROqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 10:46:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:49609 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932185AbWDROqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 10:46:44 -0400
Date: Tue, 18 Apr 2006 07:45:13 -0700
From: Greg KH <greg@kroah.com>
To: "Kazuki Omo(Company)" <k-omo@10art-ni.co.jp>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>,
       linux-kernel@vger.kernel.org, fireflier-devel@lists.sourceforge.net
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
Message-ID: <20060418144513.GA29780@kroah.com>
References: <20060417180231.71328.qmail@web36606.mail.mud.yahoo.com> <1145297742.8542.206.camel@moss-spartans.epoch.ncsc.mil> <4444E428.6070503@10art-ni.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4444E428.6070503@10art-ni.co.jp>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2006 at 10:05:44PM +0900, Kazuki Omo(Company) wrote:
> Hi,
> 
> This is my first post. My name is OMO, member of LIDS development team.
> (LIDS is not IDS. I think the name sometime will cause
>  misunderstanding.)
> 
> Actually, LIDS is using LSM Framework from kernel-2.6.0 and
> keeps developing new one.
> http://marc.theaimsgroup.com/?l=linux-security-module&m=113472048023966&w=2

That's great.  But why haven't you submitted LIDS for acceptance into
the main kernel tree?

thanks,

greg k-h
