Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266034AbUFDWua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266034AbUFDWua (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 18:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266030AbUFDWsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 18:48:16 -0400
Received: from mail.kroah.org ([65.200.24.183]:33736 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266029AbUFDWrv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 18:47:51 -0400
Date: Fri, 4 Jun 2004 15:02:58 -0700
From: Greg KH <greg@kroah.com>
To: nardelli <jnardelli@infosciences.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Memory leak in visor.c and ftdi_sio.c
Message-ID: <20040604220258.GA13920@kroah.com>
References: <40C08E6D.8080606@infosciences.com> <20040604181252.GA11499@kroah.com> <40C0C3D7.3090007@infosciences.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C0C3D7.3090007@infosciences.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2004 at 02:47:51PM -0400, nardelli wrote:
> ^*(&*(# editor not copying tabs - I should have caught that.
> Here's another try: 
> 
> 
> This was prepared against 2.6.7-rc2.

Heh, much better.  Applied, thanks.

greg k-h
