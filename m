Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422827AbWAMTFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422827AbWAMTFh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422828AbWAMTFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:05:37 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:2455
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1422827AbWAMTFg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:05:36 -0500
Subject: Re: 2.6.15-mm2: alpha broken
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Paul Jackson <pj@sgi.com>, Adrian Bunk <bunk@stusta.de>, akpm@osdl.org,
       adobriyan@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0601131014160.5563@shark.he.net>
References: <20060107052221.61d0b600.akpm@osdl.org>
	 <20060107210646.GA26124@mipter.zuzino.mipt.ru>
	 <20060107154842.5832af75.akpm@osdl.org>
	 <20060110182422.d26c5d8b.pj@sgi.com> <20060113141154.GL29663@stusta.de>
	 <20060113101054.d62acb0d.pj@sgi.com>
	 <Pine.LNX.4.58.0601131014160.5563@shark.he.net>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 20:05:42 +0100
Message-Id: <1137179143.7634.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-13 at 10:19 -0800, Randy.Dunlap wrote:
> I don't find building cross-toolchains quite as easy as Al does,
> so I download and build with these (on i386):
>   http://developer.osdl.org/dev/plm/cross_compile/
> as Andrew has also mentioned in the past.
> 
> Or one can submit kernel patches for builds to an OSDL
> build machine which does 8 or 9 $ARCH builds.

Also crosstool produces quite a bunch of working cross tool chains out
of the box. As simple as Al said.

http://www.kegel.com/crosstool/

	tglx


