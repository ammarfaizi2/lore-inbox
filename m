Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbVCZDzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbVCZDzb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 22:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbVCZDza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 22:55:30 -0500
Received: from lyle.provo.novell.com ([137.65.81.174]:10648 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261951AbVCZDzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 22:55:17 -0500
Date: Fri, 25 Mar 2005 19:54:58 -0800
From: Greg KH <gregkh@suse.de>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [0/12] More Driver Model Locking Changes
Message-ID: <20050326035458.GA18403@suse.de>
References: <Pine.LNX.4.50.0503242145200.29800-100000@monsoon.he.net> <20050325192024.GA14290@kroah.com> <20050325233952.GA16355@kroah.com> <20050326000309.GB16602@kroah.com> <Pine.LNX.4.50.0503251823280.30834-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0503251823280.30834-100000@monsoon.he.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2005 at 06:24:58PM -0800, Patrick Mochel wrote:
> On Fri, 25 Mar 2005, Greg KH wrote:
> > Oh, looks like pci express now has problems too, I'll go hit that one
> > next...
> 
> Bah, sorry about that. What config are you using to test, 'allmodconfig'?

Yup.  Looks like pci express is doing some odd stuff, I'll go fix that
up now.

thanks,

greg k-h
