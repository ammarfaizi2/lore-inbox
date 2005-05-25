Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261618AbVEYXwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbVEYXwN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 19:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVEYXwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 19:52:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:15239 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261618AbVEYXwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 19:52:10 -0400
Date: Wed, 25 May 2005 16:58:46 -0700
From: Greg KH <greg@kroah.com>
To: Lukasz Stelmach <stlman@poczta.fm>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Driver for MCS7780 USB-IrDA bridge chip
Message-ID: <20050525235846.GA28644@kroah.com>
References: <42943CB5.50400@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42943CB5.50400@poczta.fm>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2005 at 10:52:05AM +0200, Lukasz Stelmach wrote:
> You can download it from either:
> 
> http://www.ee.pw.edu.pl/~stelmacl/mcs7780-0.1alpha.1.tar.bz2
> 
> or
> 
> http://stlman.fm.interia.pl/mcs7780-0.1alpha.1.tar.bz2

Nice, care to make up a patch as per the Documentation/SubmittingPatches
file and send it to the linux-usb-devel mailing list so people can
review it?  Also, you might want to cc the netdev list for the network
stuff.

thanks,

greg k-h
