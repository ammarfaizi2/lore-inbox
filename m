Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbTLWWKv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 17:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbTLWWKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 17:10:50 -0500
Received: from mail.kroah.org ([65.200.24.183]:6890 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262603AbTLWWKq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 17:10:46 -0500
Date: Tue, 23 Dec 2003 14:07:07 -0800
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [PATCH] sysfs class patches - take 2 [0/5]
Message-ID: <20031223220707.GC15946@kroah.com>
References: <20031223212459.GA15700@kroah.com> <3FE8BA64.7070607@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FE8BA64.7070607@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23, 2003 at 04:57:56PM -0500, Jeff Garzik wrote:
> Interesting...  I bet that will be useful to the iPAQ folks (I've been 
> wading through their patches lately), as they have created a couple 
> ultra-simple classes for SoC devices and such.

I bet it will.  I've ported my old frame buffer patch to use it, and
it saved a lot of code.

Hm, I wonder if the frame buffer people ever intregrated that patch...

thanks,

greg k-h
