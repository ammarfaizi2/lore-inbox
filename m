Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267665AbUBTBbf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 20:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267684AbUBTB3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 20:29:00 -0500
Received: from mail.kroah.org ([65.200.24.183]:37038 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267667AbUBTB2D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 20:28:03 -0500
Date: Thu, 19 Feb 2004 17:11:49 -0800
From: Greg KH <greg@kroah.com>
To: Thom Borton <borton@phys.ethz.ch>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Oops 2.4.25: USB visor module - Clie synchro
Message-ID: <20040220011149.GA16456@kroah.com>
References: <200402192140.15756.borton@phys.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402192140.15756.borton@phys.ethz.ch>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 09:40:15PM +0100, Thom Borton wrote:
> 
> Hello everybody
> 
> I occasionally run into a kernel Oops when I try to sync my sony clie, 

Can you run that oops through ksymoops and send that result to us?

Also, have you tried 2.6.3?  That should sync a lot faster than 2.4

thanks,

greg k-h
