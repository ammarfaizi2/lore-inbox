Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbVKOWJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbVKOWJX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 17:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbVKOWJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 17:09:22 -0500
Received: from mail.kroah.org ([69.55.234.183]:65178 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932136AbVKOWJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 17:09:22 -0500
Date: Tue, 15 Nov 2005 13:54:03 -0800
From: Greg KH <gregkh@suse.de>
To: Avuton Olrich <avuton@gmail.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [RFC] HOWTO do Linux kernel development - take 2
Message-ID: <20051115215403.GA12116@suse.de>
References: <20051115210459.GA11363@kroah.com> <3aa654a40511151352h5771060ekf1781b9d59b26b26@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aa654a40511151352h5771060ekf1781b9d59b26b26@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 01:52:46PM -0800, Avuton Olrich wrote:
> On 11/15/05, Greg KH <gregkh@suse.de> wrote:
> 
> >  - After two weeks a -rc1 kernel is released and now is possible to push only
> >   patches that do not include new functionalities that could affect the
> >    stability of the whole kernel.  Please note that a whole new driver (or
> 
> (functionalities is not a word, this maybe better)
> 
> - After two weeks a -rc1 kernel is released and it is only possible to
> push patches which don't offer new features, or could affect the
> stability of the kernel.
> 
> > 2.6.x.y -stable kernel tree
> > ---------------------------
> > Kernels with 4 digit versions are -stable kernels. They contain
> > relativly small and critical fixes for security problems or significant
> > regressions discovered in a given 2.6.x kernel.
> 
> relatively

Nice, thanks for finding these, I've fixed them up.

greg k-h
