Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbVEJEkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbVEJEkh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 00:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVEJEkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 00:40:37 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:30173 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S261543AbVEJEkc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 00:40:32 -0400
Date: Mon, 9 May 2005 23:50:52 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Alexander Nyberg <alexn@telia.com>, Antoine Martin <antoine@nagafix.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11.8 + UML/x86_64 (2.6.12-rc3+) = oops
Message-ID: <20050510035052.GA16892@ccure.user-mode-linux.org>
References: <20050504191828.620C812EE7@sc8-sf-spam2.sourceforge.net> <1115248927.12088.52.camel@cobra> <1115392141.12197.3.camel@cobra> <1115483506.12131.33.camel@cobra> <1115481468.925.9.camel@localhost.localdomain> <20050507180356.GA10793@ccure.user-mode-linux.org> <20050508001832.GA32143@parcelfarce.linux.theplanet.co.uk> <20050508061044.GB32143@parcelfarce.linux.theplanet.co.uk> <20050509210753.GA1150@parcelfarce.linux.theplanet.co.uk> <20050510022631.GB1150@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050510022631.GB1150@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2005 at 03:26:31AM +0100, Al Viro wrote:
> Now we have
> the following:
> 	uml/i386 - all variants work
> 	uml/amd64 TT-only - panics in execve() on /sbin/init (hey, a progress)
> 	uml/amd64 other variants - work

Nice, send patches when you get a chance?

				Jeff
