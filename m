Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262171AbVC2DhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbVC2DhD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 22:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262173AbVC2DhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 22:37:02 -0500
Received: from mail.kroah.org ([69.55.234.183]:38283 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262171AbVC2Dg6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 22:36:58 -0500
Date: Mon, 28 Mar 2005 19:36:46 -0800
From: Greg KH <greg@kroah.com>
To: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
Message-ID: <20050329033646.GB6990@kroah.com>
References: <20050326182828.GA8540@kroah.com> <Pine.LNX.4.10.10503281632100.18224-100000@mtfhpc.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10503281632100.18224-100000@mtfhpc.demon.co.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2005 at 05:52:37PM +0100, Mark Fortescue wrote:
> Hi Greg,
> 
> If you read the Linux Kernel header file "linux/module.h", there is a
> section about Licenses. If "Proprietary" licences are not leagal, then why
> are they supported ?

They are not "supported" in any sense of the word.

> The implication of providing support for them in the header file is that
> it is leagal to create and supply them.

I'm sorry, but you need to consult with a lawyer about this issue, as I
am not one, and you are asking me legal questions and asking for my
advice, which is not the wisest thing to do :)

Also, the current symbol markings for the sysfs and driver code
interfaces are going to remain as is.

thanks,

greg k-h
