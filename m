Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932767AbWEXVfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932767AbWEXVfa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 17:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932768AbWEXVfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 17:35:30 -0400
Received: from ns.suse.de ([195.135.220.2]:26558 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932767AbWEXVf3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 17:35:29 -0400
Date: Wed, 24 May 2006 14:33:10 -0700
From: Greg KH <greg@kroah.com>
To: vamsi krishna <vamsi.krishnak@gmail.com>
Cc: linux-kernel@vger.kernel.org, dan@debian.org
Subject: Re: Program to convert core file to executable.
Message-ID: <20060524213310.GA12371@kroah.com>
References: <3faf05680605241018q302d5c0em6844765f81669498@mail.gmail.com> <20060524173821.GA1292@nevyn.them.org> <3faf05680605241306t64f63225i4d25af3e92a9d9f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3faf05680605241306t64f63225i4d25af3e92a9d9f9@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 01:36:08AM +0530, vamsi krishna wrote:
> >
> >Of course, the kernel shouldn't crash!  It sounds like a bug.
> >
> 
> Yes I can reproduce this , is there a bugzilla for kernel? (or should
> we report this at the buzilla of the distribution?)

For security issues such as this (ability for users to crash the
kernel), security@kernel.org is the best address to send this to.

thanks,

greg k-h
