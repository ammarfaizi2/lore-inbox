Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932558AbWCWXdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558AbWCWXdR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 18:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbWCWXdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 18:33:17 -0500
Received: from mail.kroah.org ([69.55.234.183]:51595 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932558AbWCWXdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 18:33:16 -0500
Date: Thu, 23 Mar 2006 15:25:51 -0800
From: Greg KH <greg@kroah.com>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: linux-kernel@vger.kernel.org, rdreier@cisco.com, openib-general@openib.org
Subject: Re: [PATCH 8 of 18] ipath - sysfs and ipathfs support for core driver
Message-ID: <20060323232551.GA31490@kroah.com>
References: <patchbomb.1143072293@eng-12.pathscale.com> <03375633b9c13068de17.1143072301@eng-12.pathscale.com> <20060323054905.GB20672@kroah.com> <1143103485.6411.14.camel@camp4.serpentine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143103485.6411.14.camel@camp4.serpentine.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 12:44:45AM -0800, Bryan O'Sullivan wrote:
> On Wed, 2006-03-22 at 21:49 -0800, Greg KH wrote:
> > Oh, and I like your new filesystem, but where do you propose that it be
> > mounted?
> 
> I don't have any good candidates in mind.  In our development
> environment, we're mounting it in /ipath, but that doesn't seem like a
> good long-term name.  Do you have any suggestions?

Nope, sorry.  At least /ipath is LSB compliant :)

thanks,

greg k-h
