Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbULXA7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbULXA7k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 19:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbULXA7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 19:59:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48621 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261352AbULXA7j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 19:59:39 -0500
Date: Thu, 23 Dec 2004 19:59:00 -0500
From: Alan Cox <alan@redhat.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix inlining related build failures in mxser.c
Message-ID: <20041224005900.GA22106@devserv.devel.redhat.com>
References: <Pine.LNX.4.61.0412240155070.3504@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0412240155070.3504@dragon.hygekrogen.localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2004 at 02:01:18AM +0100, Jesper Juhl wrote:
> An allyesconfig build of 2.6.10-rc3-bk16 revealed the following build 
> failures (which arefixed by the patch below) :

Please send it on to Linus. I've never tried to build any moxa driver with
such a new compiler version. It looks the right thing to do.

(Moxa support removed from cc list)

Alan

