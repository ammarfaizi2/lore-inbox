Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264210AbTEOUHR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 16:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264212AbTEOUFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 16:05:32 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:63408 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264210AbTEOUFN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 16:05:13 -0400
Date: Thu, 15 May 2003 13:19:36 -0700
From: Greg KH <greg@kroah.com>
To: jt@hpl.hp.com
Cc: Martin Diehl <lists@mdiehl.de>, Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.69] rtnl-deadlock with usermodehelper and keventd
Message-ID: <20030515201936.GA10591@kroah.com>
References: <Pine.LNX.4.44.0305151443180.1435-100000@notebook.home.mdiehl.de> <20030515201255.GA18643@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030515201255.GA18643@bougret.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 01:12:55PM -0700, jt@bougret.hpl.hp.com wrote:
> 	Greg,
> 
> 	This is a HotPlug problem, so would you mind forwarding this
> to the relevant person and help Martin ?

But it's a networking subsystem hotplug problem, right?  That's way out
of my league.

I do agree it looks like a real problem, Martin did a great job in
tracking this down.

thanks,

greg k-h
