Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751597AbVLFEMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbVLFEMf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 23:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbVLFEMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 23:12:35 -0500
Received: from mail.kroah.org ([69.55.234.183]:53399 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751596AbVLFEMf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 23:12:35 -0500
Date: Mon, 5 Dec 2005 20:12:16 -0800
From: Greg KH <greg@kroah.com>
To: Tim Bird <tim.bird@am.sony.com>
Cc: David Woodhouse <dwmw2@infradead.org>, arjan@infradead.org,
       andrew@walrond.org, linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
Message-ID: <20051206041215.GC26602@kroah.com>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org> <200512051826.06703.andrew@walrond.org> <1133817575.11280.18.camel@localhost.localdomain> <1133817888.9356.78.camel@laptopd505.fenrus.org> <1133819684.11280.38.camel@localhost.localdomain> <4394D396.1020102@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4394D396.1020102@am.sony.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 03:56:06PM -0800, Tim Bird wrote:
> DISCLAIMER: I'm not speaking for Sony here. Personally
> I don't believe that most drivers are derivative works
> of the operating systems they run with, and I don't
> believe it helps Linux to assert that they are.
> But, hey, it's not my kernel, and not my plan for
> world domination. ;-)

Why do people bring up the "derivative works" issue all the time.  Are
they so blind to the very simple "linking" issue that all kernel modules
do when they are loaded into the kernel?

That's the much simpler reason for why numerous IP lawyers of big
companies that do Linux work feel that closed source Linux kernel
modules are not legal.

thanks,

greg k-h
