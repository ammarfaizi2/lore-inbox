Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266105AbUBJRrB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 12:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266110AbUBJRnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 12:43:49 -0500
Received: from mail.kroah.org ([65.200.24.183]:10881 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266105AbUBJRnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 12:43:04 -0500
Date: Tue, 10 Feb 2004 09:35:51 -0800
From: Greg KH <greg@kroah.com>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Newest fbdev patch to go mainline.
Message-ID: <20040210173551.GC27779@kroah.com>
References: <Pine.LNX.4.44.0402100634430.32169-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0402100634430.32169-100000@phoenix.infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 06:36:03AM +0000, James Simmons wrote:
> 
> First step to incorporate the new cursor api. It s abig patch so I broke 
> it into pieces. Give it a try.

How about fixing up the problem in the in-kernel version of fb that Al
Viro and I pointed out?

thanks,

greg k-h
