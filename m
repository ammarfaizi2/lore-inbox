Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267841AbUIMQsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267841AbUIMQsp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 12:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267555AbUIMQrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 12:47:01 -0400
Received: from mail.kroah.org ([69.55.234.183]:2272 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267841AbUIMQmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 12:42:53 -0400
Date: Mon, 13 Sep 2004 09:42:08 -0700
From: Greg KH <greg@kroah.com>
To: Constantine Gavrilov <constg@qlusters.com>
Cc: Christoph Hellwig <hch@infradead.org>, bugs@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: Calling syscalls from x86-64 kernel results in a crash on Opteron machines
Message-ID: <20040913164208.GA17383@kroah.com>
References: <4145A8E1.8010409@qlusters.com> <20040913153803.A27282@infradead.org> <4145B750.6060900@qlusters.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4145B750.6060900@qlusters.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2004 at 06:05:52PM +0300, Constantine Gavrilov wrote:
> What I am writing is an application, and not interface. As such, it is 
> not much different from its requierements from a user-space application. 
> If user-space application may call system calls, why a kernel space 
> application cannot?
> 
> And BTW, kernel-space applications have their own place even if the 
> concept seems foreign to you.

What kind of application is this?

And do you have a link to your source code available?

thanks,

greg k-h
