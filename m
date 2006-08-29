Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWH2CJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWH2CJJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 22:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbWH2CJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 22:09:09 -0400
Received: from mail.kroah.org ([69.55.234.183]:40648 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932088AbWH2CJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 22:09:07 -0400
Date: Mon, 28 Aug 2006 19:01:07 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>, 76306.1226@compuserve.com
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.18-rc5
Message-ID: <20060829020107.GA31565@kroah.com>
References: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org> <20060827231421.f0fc9db1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060827231421.f0fc9db1.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2006 at 11:14:21PM -0700, Andrew Morton wrote:
> On Sun, 27 Aug 2006 21:30:50 -0700 (PDT)
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > Linux 2.6.18-rc5 is out there now
> 
> (Reporters Bcc'ed: please provide updates)
> 
> Serious-looking regressions include:
> 
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=7062 (HPET)
> 
> From: Chuck Ebbert <76306.1226@compuserve.com>
> Subject: PCI: Cannot allocate resource region 7 of bridge 0000:00:04.0

I thought this was resolved.

Chuck, do you still have issues with this with the -rc5 release?

thanks,

greg k-h
