Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbVFTQsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVFTQsJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 12:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbVFTQsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 12:48:09 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:63100 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261324AbVFTQsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 12:48:07 -0400
Date: Mon, 20 Jun 2005 09:48:00 -0700
From: Greg KH <gregkh@suse.de>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Nick Warne <nick@linicks.net>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.12 udev hangs at boot
Message-ID: <20050620164800.GA14798@suse.de>
References: <200506181332.25287.nick@linicks.net> <42B45173.6060209@pobox.com> <200506181806.49627.nick@linicks.net> <200506201304.10741.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506201304.10741.vda@ilport.com.ua>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 01:04:10PM +0300, Denis Vlasenko wrote:
> 
> Greg, any plans to distribute udev and hotplug within kernel tarballs
> so that people do not need to track such changes continuously?

Nope.  But if you use udev, you should read the announcements for new
releases, as I did say this was required for 2.6.12, and gave everyone a
number of weeks notice :)

thanks,

greg k-h
