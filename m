Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbTIZVNu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 17:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbTIZVNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 17:13:50 -0400
Received: from mail.kroah.org ([65.200.24.183]:39566 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261631AbTIZVNq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 17:13:46 -0400
Date: Fri, 26 Sep 2003 14:12:40 -0700
From: Greg KH <greg@kroah.com>
To: =?iso-8859-1?Q?B=F6rkur_Ingi_J=F3nsson?= <bugsy@isl.is>
Cc: linux-kernel@vger.kernel.org
Subject: Re: khubd is a Succubus!
Message-ID: <20030926211239.GA18220@kroah.com>
Reply-To: linux-kernel@vger.kernel.org
References: <200309261724.56616.bugsy@isl.is> <200309261843.10099.bugsy@isl.is> <20030926183522.GB17690@kroah.com> <200309262114.46531.bugsy@isl.is>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200309262114.46531.bugsy@isl.is>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 26, 2003 at 09:14:46PM +0000, Börkur Ingi Jónsson wrote:
> nvidia: no version magic, tainting kernel.
> nvidia: module license 'NVIDIA' taints kernel.

Again, can you do this without the nvidia driver?  With it installed, no
one here will be able to help you out.

And I didn't see anything unusual in your kernel logs either.  Does the
USB keyboard work ok?

thanks,

greg k-h
