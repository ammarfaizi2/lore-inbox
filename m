Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261587AbVEUO5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbVEUO5P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 10:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261591AbVEUO5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 10:57:15 -0400
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:51217
	"HELO linuxace.com") by vger.kernel.org with SMTP id S261587AbVEUO5M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 10:57:12 -0400
Date: Sat, 21 May 2005 07:57:11 -0700
From: Phil Oester <kernel@linuxace.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc4 random oopses
Message-ID: <20050521145711.GA28132@linuxace.com>
References: <20050519153324.GA17914@linuxace.com> <E1DZOFT-0001JJ-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DZOFT-0001JJ-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2005 at 05:18:15PM +1000, Herbert Xu wrote:
> How long can your machine stay up under 2.6.11/2.6.12-rc4? Is 2.6.10
> still stable if rebuild it?

Machine stays up 'forever' on 2.6.10, dies within ~4 hours on 2.6.11+.
Yes, I have rebuilt 2.6.10 with some backported patches, and it still
works fine.

> If 2.6.10 is still proving to be stable, then please do a bisection
> search on the releases between 2.6.10/2.6.11.  That may be the only
> way we can track this problem down.

Unfortunately the box is the firewall for my employer's west coast office
so I can only get away with one unexplained natural phenomenon per
day.  May take awhile...

Phil 
