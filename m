Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265881AbTIJXY6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 19:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265997AbTIJXY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 19:24:58 -0400
Received: from mail.kroah.org ([65.200.24.183]:52195 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265881AbTIJXY5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 19:24:57 -0400
Date: Wed, 10 Sep 2003 16:25:11 -0700
From: Greg KH <greg@kroah.com>
To: Ranjeet Shetye <ranjeet.shetye2@zultys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] Linux-2.6.0-test5-bk
Message-ID: <20030910232511.GA6422@kroah.com>
References: <1063232210.4441.14.camel@ranjeet-pc2.zultys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063232210.4441.14.camel@ranjeet-pc2.zultys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 03:16:50PM -0700, Ranjeet Shetye wrote:
> 
> file: oops4.ksyms.txt: the OOPS that I got.
> file: oops4.bt.txt: ksymoops-derived backtrace of OOPS.
> file: .config - my .config file.
> 
> To verify that this is not a compilation problem, I ran a 'make
> mrproper' and compiled from scratch.
> 
> Something to note: module support is disabled and I remember that
> sometime back you needed to have ALSA compiled as a module, and this
> OOPS is in ALSA. Is it still necessary to compile ALSA as a module ?
> 
> I am not on the kernel mailing list, (only on linux-net and netdev). So
> please email me personally if you need any other information.

What were you doing that caused this oops?

thanks,

greg k-h
