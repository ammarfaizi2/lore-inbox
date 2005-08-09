Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbVHIOhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbVHIOhL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 10:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbVHIOhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 10:37:11 -0400
Received: from van-1-67.lab.dnainternet.fi ([62.78.96.67]:14241 "EHLO
	mail.zmailer.org") by vger.kernel.org with ESMTP id S964787AbVHIOhK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 10:37:10 -0400
Date: Tue, 9 Aug 2005 17:37:05 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
Subject: Re: Soft lockup in e100 driver ?
Message-ID: <20050809143705.GM22165@mea-ext.zmailer.org>
References: <20050809133647.GK22165@mea-ext.zmailer.org> <9a87484905080906556d9f531c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a87484905080906556d9f531c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2005 at 03:55:49PM +0200, Jesper Juhl wrote:
> On 8/9/05, Matti Aarnio <matti.aarnio@zmailer.org> wrote:
> > Running very recent Fedora Core Development kernel I can following
> > soft-oops..   ( 2.6.12-1.1455_FC5smp )
> > 
> Various patches to the e100 driver have been merged since 2.6.12.1
> (which is ~1.5months old), so it would make sense to try a more recent
> kernel like 2.6.13-rc6, 2.6.13-rc6-git1 or 2.6.13-rc5-mm1 and see if
> you can still reproduce the problem with those.

The kernel in question is less than 3 days old RedHat Fedora Core
Development kernel with baseline as:
  * Sun Aug 07 2005 Dave Jones <davej@redhat.com>
    - 2.6.13-rc5-git4

Those merges have not helped.

> -- 
> Jesper Juhl <jesper.juhl@gmail.com>

  /Matti Aarnio
