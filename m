Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbTHUUYt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 16:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262876AbTHUUYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 16:24:49 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:63244 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S262796AbTHUUYs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 16:24:48 -0400
Date: Thu, 21 Aug 2003 22:22:20 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, Jeff Garzik <jgarzik@pobox.com>,
       gkajmowi@tbaytel.net, linux-kernel@vger.kernel.org
Subject: Re: Initramfs
Message-ID: <20030821202220.GD734@alpha.home.local>
References: <200308210044.17876.gkajmowi@tbaytel.net> <1061447419.19503.20.camel@camp4.serpentine.com> <3F44D504.7060909@pobox.com> <1061490490.23060.9.camel@serpentine.internal.keyresearch.com> <20030821190358.GF454@parcelfarce.linux.theplanet.co.uk> <1061495854.23060.12.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1061495854.23060.12.camel@serpentine.internal.keyresearch.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 21, 2003 at 12:57:34PM -0700, Bryan O'Sullivan wrote:
> On Thu, 2003-08-21 at 12:03, viro@parcelfarce.linux.theplanet.co.uk
> wrote:
> 
> > RTFM.  cpio -o -H newc should be used to create an archive; _not_ the
> > "binary" format that is default.
> 
> There is no FM to R in this regard.

Except if he meant "Reclaim The Future Manual"
:-)
