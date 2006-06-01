Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965236AbWFAR3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965236AbWFAR3d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 13:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965232AbWFAR3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 13:29:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2951 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965236AbWFAR3c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 13:29:32 -0400
Date: Thu, 1 Jun 2006 10:33:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: earny@net4u.de
Cc: list-lkml@net4u.de, ink@jurassic.park.msu.ru, linux-kernel@vger.kernel.org,
       rth@twiddle.net
Subject: Re: ALPHA 2.6.17-rc5 AIC7###: does not boot
Message-Id: <20060601103346.3e3544ab.akpm@osdl.org>
In-Reply-To: <200606011911.36962.list-lkml@net4u.de>
References: <200605301834.19795.list-lkml@net4u.de>
	<20060531154648.53539006.akpm@osdl.org>
	<20060601201619.A978@jurassic.park.msu.ru>
	<200606011911.36962.list-lkml@net4u.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2006 19:11:36 +0200
Ernst Herzberg <list-lkml@net4u.de> wrote:

> > Ernst, please try this patch.
> >
> > Ivan.
> >
> 
> Yesss Sir! The patch works.

Thanks, guys.

Ivan, should I scoot that patch into 2.6.17 as-is?
