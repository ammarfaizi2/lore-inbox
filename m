Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262340AbUKWI6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbUKWI6R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 03:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262336AbUKWI6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 03:58:16 -0500
Received: from sd291.sivit.org ([194.146.225.122]:3036 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262340AbUKWI5a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 03:57:30 -0500
Date: Tue, 23 Nov 2004 09:57:29 +0100
From: Luc Saillard <luc@saillard.org>
To: Greg KH <greg@kroah.com>
Cc: Shawn Starr <shawn.starr@rogers.com>, linux-kernel@vger.kernel.org
Subject: Re: new pwc driver for 2.6 - Merge into -mm?
Message-ID: <20041123085729.GC4650@sd291.sivit.org>
References: <200411210141.45122.shawn.starr@rogers.com> <20041123082452.GF23974@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123082452.GF23974@kroah.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2004 at 12:24:52AM -0800, Greg KH wrote:
> On Sun, Nov 21, 2004 at 01:41:44AM -0500, Shawn Starr wrote:
> > 
> > Is it possible the driver can be put into -mm for testing or are there (legal) 
> > issues that need to be addressed in any way?
> 
> Someone needs to actually submit the patch...

Before that, i prefer to finish to fix some bugs in my v4l2 implementation
(next release), and add (if possible) code to handle old compressed stream.

Luc
