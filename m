Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWHBTlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWHBTlV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 15:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWHBTlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 15:41:21 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:31361 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932186AbWHBTlU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 15:41:20 -0400
Date: Wed, 2 Aug 2006 12:42:36 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Michael Halcrow <mhalcrow@us.ibm.com>
Cc: Greg KH <greg@kroah.com>, Chris Wright <chrisw@sous-sol.org>,
       Andrew Morton <akpm@osdl.org>, serue@us.ibm.com,
       Stephen Smalley <sds@tycho.nsa.gov>,
       Davi Arnaut <davi.arnaut@gmail.com>, jmorris@namei.org,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] LSM: remove BSD secure level security module
Message-ID: <20060802194236.GV2654@sequoia.sous-sol.org>
References: <20060802180708.GQ2654@sequoia.sous-sol.org> <20060802182311.GA19638@kroah.com> <20060802191416.GA3227@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060802191416.GA3227@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Michael Halcrow (mhalcrow@us.ibm.com) wrote:
> On Wed, Aug 02, 2006 at 11:23:11AM -0700, Greg KH wrote:
> > On Wed, Aug 02, 2006 at 11:07:08AM -0700, Chris Wright wrote:
> > > This code has suffered from broken core design and lack of developer
> > > attention.  Broken security modules are too dangerous to leave around.
> > > It is time to remove this one.
> > > 
> > > Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> > > Cc: Michael Halcrow <mhalcrow@us.ibm.com>
> > > Cc: Serge Hallyn <serue@us.ibm.com>
> > > Cc: Davi Arnaut <davi.arnaut@gmail.com>
> > 
> > Don't know if it really matters, but I really agree.  Feel free to add:
> > 	Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> > 
> > if you want to.
> 
> Is this accomplished by dropping patches or by adding a patch to
> remove the files? In any case, here is a patch to do the latter...

I don't follow.  I sent a patch...

thanks,
-chris
