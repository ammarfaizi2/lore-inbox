Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270182AbUJSXrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270182AbUJSXrj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268086AbUJSXqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:46:40 -0400
Received: from mail.kroah.org ([69.55.234.183]:60059 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270182AbUJSX2H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 19:28:07 -0400
Date: Tue, 19 Oct 2004 16:27:10 -0700
From: Greg KH <greg@kroah.com>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>, torvalds@osdl.org, akpm@osdl.org
Subject: Re: BK kernel workflow
Message-ID: <20041019232710.GA10841@kroah.com>
References: <41752E53.8060103@pobox.com> <20041019153126.GG18939@work.bitmover.com> <41753B99.5090003@pobox.com> <4d8e3fd304101914332979f86a@mail.gmail.com> <20041019213803.GA6994@havoc.gtf.org> <4d8e3fd3041019145469f03527@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d8e3fd3041019145469f03527@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2004 at 11:54:16PM +0200, Paolo Ciarrocchi wrote:
> I know I'm pedantic but can we all see the list of bk trees ("patches
> ready for mainstream" and "patches eventually ready for mainstream")
> that we'll be used by Linus ?

The -mm releases has these as a big patch, starting with bk-*

Those should give you an idea of what is being staged, before it is sent
to Linus.

thanks,

greg k-h
