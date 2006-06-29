Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbWF2ShE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWF2ShE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 14:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWF2ShE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 14:37:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8143 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751089AbWF2ShC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 14:37:02 -0400
Date: Thu, 29 Jun 2006 11:36:42 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Greg KH <gregkh@suse.de>, pbadari@us.ibm.com, linux-kernel@vger.kernel.org,
       kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: 2.6.17-git14 compile failure & fix
In-Reply-To: <20060629112952.c7231034.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0606291135320.12404@g5.osdl.org>
References: <44A40874.20202@us.ibm.com> <20060629172016.GA23736@suse.de>
 <20060629112952.c7231034.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Jun 2006, Andrew Morton wrote:
> > 
> > Linus, here's the summary again below if you want to pull.  When you
> > merge, there might be some conflicts you have to handle, but hey, you
> > can test out your new git merge code :)
> 
> Yes, please let's get this in.

It was part of this mornings merge-queue, and is pushed out now.

		Linus
