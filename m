Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265038AbUGBWzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265038AbUGBWzg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 18:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265040AbUGBWzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 18:55:36 -0400
Received: from mail.kroah.org ([65.200.24.183]:431 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265038AbUGBWzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 18:55:35 -0400
Date: Fri, 2 Jul 2004 15:49:27 -0700
From: Greg KH <greg@kroah.com>
To: Markus Schaber <schabios@logi-track.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at drivers/usb/storage/usb.c:848
Message-ID: <20040702224927.GB7969@kroah.com>
References: <20040701121836.07db4217@kingfisher.intern.logi-track.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040701121836.07db4217@kingfisher.intern.logi-track.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2004 at 12:18:36PM +0200, Markus Schaber wrote:
> Hello,
> 
> Running Kernel 2.6.4-mm2 (We use an mm2 kernel because of problems with
> highmem and cryto-loop playing together which seemed to be solved in
> mm2) and dd'ing from a IDE disk in an external USB case, the following
> just happened (from /var/log/syslog):

2.6.4-mm2 is quite an old kernel.  Care to get a newer one to see if
this is still an issue or not?

thanks,

greg k-h
