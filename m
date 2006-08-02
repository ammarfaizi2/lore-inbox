Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWHBS2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWHBS2S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 14:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWHBS2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 14:28:17 -0400
Received: from ns.suse.de ([195.135.220.2]:32399 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932131AbWHBS2R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 14:28:17 -0400
Date: Wed, 2 Aug 2006 11:23:11 -0700
From: Greg KH <greg@kroah.com>
To: Chris Wright <chrisw@sous-sol.org>
Cc: Andrew Morton <akpm@osdl.org>, Michael Halcrow <mhalcrow@us.ibm.com>,
       serue@us.ibm.com, Stephen Smalley <sds@tycho.nsa.gov>,
       Davi Arnaut <davi.arnaut@gmail.com>, jmorris@namei.org,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] LSM: remove BSD secure level security module
Message-ID: <20060802182311.GA19638@kroah.com>
References: <20060802180708.GQ2654@sequoia.sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060802180708.GQ2654@sequoia.sous-sol.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2006 at 11:07:08AM -0700, Chris Wright wrote:
> This code has suffered from broken core design and lack of developer
> attention.  Broken security modules are too dangerous to leave around.
> It is time to remove this one.
> 
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> Cc: Michael Halcrow <mhalcrow@us.ibm.com>
> Cc: Serge Hallyn <serue@us.ibm.com>
> Cc: Davi Arnaut <davi.arnaut@gmail.com>

Don't know if it really matters, but I really agree.  Feel free to add:
	Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

if you want to.

thanks,

greg k-h
