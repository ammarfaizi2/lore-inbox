Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266144AbUBJRx1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 12:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266010AbUBJRua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 12:50:30 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:30477 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266097AbUBJRt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 12:49:56 -0500
Date: Tue, 10 Feb 2004 17:49:52 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Greg KH <greg@kroah.com>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Newest fbdev patch to go mainline.
In-Reply-To: <20040210173551.GC27779@kroah.com>
Message-ID: <Pine.LNX.4.44.0402101747450.6600-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Thats coming :-) The problem only showes itself with modular drivers 
correct. So I will submit patches for those first. I just wanted to polish 
off a few really tiny patches fist.

On Tue, 10 Feb 2004, Greg KH wrote:

> On Tue, Feb 10, 2004 at 06:36:03AM +0000, James Simmons wrote:
> > 
> > First step to incorporate the new cursor api. It s abig patch so I broke 
> > it into pieces. Give it a try.
> 
> How about fixing up the problem in the in-kernel version of fb that Al
> Viro and I pointed out?
> 
> thanks,
> 
> greg k-h
> 

