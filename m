Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbUCIPQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 10:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbUCIPQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 10:16:47 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:53699 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S261988AbUCIPQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 10:16:44 -0500
Date: Tue, 9 Mar 2004 10:16:40 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Ben Collins <bcollins@debian.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: OOPS when copying data from local to an external drive (ieee1394)
In-Reply-To: <200403090211.33930.dtor_core@ameritech.net>
Message-ID: <Pine.LNX.4.58.0403091015280.29087@montezuma.fsmlabs.com>
References: <200403070139.30268.dtor_core@ameritech.net>
 <Pine.LNX.4.58.0403070229490.29087@montezuma.fsmlabs.com>
 <200403090211.33930.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Mar 2004, Dmitry Torokhov wrote:

> > Does this patch help any?
> >
>
> Unfortunately I am still getting oopses with exactly the same call trace.
> On top of that I am now seeing the following in the logs:

Thanks for testing it, the messages below look like they may be due to
something else.

> I did not have these messages before. The kernel was pulled today
> from bkbits plus your patch (and some of my patches but they only
> affect input drivers).

Just to reconfirm could you backout my patch from that and retry?

Thanks,
	Zwane

