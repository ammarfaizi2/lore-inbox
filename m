Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270104AbTGMEOh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 00:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270095AbTGMENW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 00:13:22 -0400
Received: from mail.kroah.org ([65.200.24.183]:19158 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270097AbTGMENK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 00:13:10 -0400
Date: Sat, 12 Jul 2003 21:17:36 -0700
From: Greg KH <greg@kroah.com>
To: Mark Cooke <mpc@star.sr.bham.ac.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22pre3 / pwc / emi disconnect == oops, workaround
Message-ID: <20030713041736.GD2695@kroah.com>
References: <1058024543.8030.3.camel@sage.kitchen>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058024543.8030.3.camel@sage.kitchen>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 12, 2003 at 04:42:23PM +0100, Mark Cooke wrote:
> 
> PS. I've recently changed the physical layout of the machine, and it
> seems the new cabling layout causes these occasional EMI issues.

Then change it back!
EMI issues are electrical issues.  The kernel can't really do anything
about them.

But it can not oops, that's not very nice...

thanks,

greg k-h
