Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262833AbVCJQzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262833AbVCJQzk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 11:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262749AbVCJQu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 11:50:57 -0500
Received: from mail.kroah.org ([69.55.234.183]:32415 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262744AbVCJQtB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 11:49:01 -0500
Date: Thu, 10 Mar 2005 08:48:47 -0800
From: Greg KH <greg@kroah.com>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: binary drivers and development
Message-ID: <20050310164847.GA16430@kroah.com>
References: <423075B7.5080004@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <423075B7.5080004@comcast.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 11:28:39AM -0500, John Richard Moser wrote:
> I've been looking at the UDI project[1] and thinking about binary
> drivers and the like, and wondering what most peoples' take on these are
> and what impact that UDI support would have on the kernel's development.

Please, the UDI stuff has been proven to be broken and wrong.  If you
want to work on it, feel free to do so, just don't expect for anyone to
accept the UDI layer into the kernel mainline.

What's that phrase about people forgetting history are doomed...

greg k-h
