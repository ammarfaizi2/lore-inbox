Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263774AbTJ0Xni (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 18:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbTJ0Xnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 18:43:37 -0500
Received: from mail.kroah.org ([65.200.24.183]:24005 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263774AbTJ0Xnf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 18:43:35 -0500
Date: Mon, 27 Oct 2003 15:39:34 -0800
From: Greg KH <greg@kroah.com>
To: Mark Bellon <mbellon@mvista.com>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: ANNOUNCE: User-space System Device Enumeration (uSDE)
Message-ID: <20031027233934.GA3408@kroah.com>
References: <Pine.LNX.4.44.0310271343170.13116-100000@cherise> <3F9DA5A6.3020008@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F9DA5A6.3020008@mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 27, 2003 at 04:09:26PM -0700, Mark Bellon wrote:
> The uSDE was built in response to a set of telco and embedded community 
> requirements. We found it difficult to express our ideas. Everyone 
> wanted to see code and documentation. Here is the code and the initial 
> documentation. This is a starting point...
> 
> >If not, are you planning on merging your efforts with udev in the future?
> >
> It is to everyone's advantage to converge on an implementation of 
> enumeration that meets all of the requirements.

What are your requirements, and why does udev not meet them?  Is there
some major disagreement between what udev does, and what you want to do?
If so, what?

udev has been out in the world since April, any reason for not helping
out with the existing project instead of going off and starting your
own?  It's not that I mind competing projects, it's just that I don't
see your reasoning as to why there needs to be two different ones.

thanks,

greg k-h
