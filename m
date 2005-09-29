Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbVI2QQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbVI2QQD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 12:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbVI2QQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 12:16:03 -0400
Received: from mail.kroah.org ([69.55.234.183]:12977 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932228AbVI2QQB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 12:16:01 -0400
Date: Thu, 29 Sep 2005 09:12:36 -0700
From: Greg KH <greg@kroah.com>
To: Roland Dreier <rolandd@cisco.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [git pull] InfiniBand fixes for 2.6.14
Message-ID: <20050929161236.GB19770@kroah.com>
References: <524q85on6e.fsf@cisco.com> <20050928093633.GA12757@kroah.com> <52zmpxmhm0.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52zmpxmhm0.fsf@cisco.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2005 at 06:44:55AM -0700, Roland Dreier wrote:
>     Greg> I didn't think that git pulls were going to be allowed from
>     Greg> subsystem maintainers after -rc1 came out.  After that,
>     Greg> patches by email were required to be sent, not git pulls.
>     Greg> This does cause a bit more work for the maintainer, but it
>     Greg> ensures that they only send the patches they really want to
>     Greg> get in.
> 
> I specifically asked Linus about this a couple of weeks ago, and he
> said that bug-fix-only git merges are file.  See http://lkml.org/lkml/2005/9/13/277

Ah, thanks for pointing me to that, I missed that.

greg k-h
