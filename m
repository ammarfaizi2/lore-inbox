Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265316AbSJXDzY>; Wed, 23 Oct 2002 23:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265317AbSJXDzX>; Wed, 23 Oct 2002 23:55:23 -0400
Received: from rth.ninka.net ([216.101.162.244]:48279 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S265316AbSJXDzX>;
	Wed, 23 Oct 2002 23:55:23 -0400
Subject: Re: feature request - why not make netif_rx() a pointer?
From: "David S. Miller" <davem@rth.ninka.net>
To: Slavcho Nikolov <snikolov@okena.com>
Cc: jt@hpl.hp.com, Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@mandrakesoft.com>
In-Reply-To: <004c01c27a99$927b8a30$800a140a@SLNW2K>
References: <20021023003959.GA23155@bougret.hpl.hp.com> 
	<004c01c27a99$927b8a30$800a140a@SLNW2K>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 23 Oct 2002 21:13:25 -0700
Message-Id: <1035432805.9626.4.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-23 at 06:39, Slavcho Nikolov wrote:
> As for GPL, I hope that commercial enterprises be allowed to utilize
> business models
> which do not necessarily consist in providing services around free software.
> The more replaceable hooks you provide to filesystems and network stacks,
> the better.

While more hooks may be in your interest, they are not in the interest
of free software.

I really hope you have competant legal advice for the things you are
doing, because binary-only derivative works of a GPL work are illegal.

