Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966118AbWKKLNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966118AbWKKLNk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 06:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966124AbWKKLNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 06:13:40 -0500
Received: from [82.147.220.122] ([82.147.220.122]:27008 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S966118AbWKKLNj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 06:13:39 -0500
From: Al Boldi <a1426z@gawab.com>
To: David Miller <davem@davemloft.net>
Subject: Re: A proposal; making 2.6.20 a bugfix only version.
Date: Sat, 11 Nov 2006 14:15:46 +0300
User-Agent: KMail/1.5
Cc: shemminger@osdl.org, arjan@infradead.org, rdunlap@xenotime.net,
       jesper.juhl@gmail.com, linux-kernel@vger.kernel.org
References: <20061110133101.4e6cddd3@freekitty> <20061110210917.2bd568ab@localhost.localdomain> <20061110.232342.35009769.davem@davemloft.net>
In-Reply-To: <20061110.232342.35009769.davem@davemloft.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200611111415.46691.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote:
> From: Stephen Hemminger <shemminger@osdl.org>
> Date: Fri, 10 Nov 2006 21:09:17 -0800
>
> > On Sat, 11 Nov 2006 07:15:49 +0300
> >
> > Al Boldi <a1426z@gawab.com> wrote:
> > > Stephen Hemminger wrote:
> > > > Al Boldi <a1426z@gawab.com> wrote:
> > >
> > > I meant structural OSI compliance.
> >
> > Read the book "Network Algorithmics"; it has a clear discussion
> > of why building your stack like the protocol specification
> > is a bad idea.
>
> Even Van Jacobson can be quoted as saying (to the effect) that
> layering is how you design protocols, _NOT_ how you implement
> them.

The problem is that you let the implementation surface into user-land.


Thanks!

--
Al

