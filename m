Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266314AbUFUQnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266314AbUFUQnr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 12:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266315AbUFUQnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 12:43:47 -0400
Received: from host61.200-117-131.telecom.net.ar ([200.117.131.61]:13952 "EHLO
	smtp.bensa.ar") by vger.kernel.org with ESMTP id S266314AbUFUQnl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 12:43:41 -0400
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-bk way too fast
Date: Mon, 21 Jun 2004 13:55:25 -0300
User-Agent: KMail/1.6.2
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       torvalds@osdl.org
References: <40D64DF7.5040601@pobox.com> <20040621014837.6b52fa2e.akpm@osdl.org> <1087814830.1691.9.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1087814830.1691.9.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200406211355.26055.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana wrote:
> On Mon, 2004-06-21 at 01:48 -0700, Andrew Morton wrote:
> > Jeff Garzik <jgarzik@pobox.com> wrote:
> > > Something is definitely screwy with the latest -bk.
> >
> > Would you believe that there is a totally separate bug in the latest -mm
> > which has exactly the same symptoms?
>
> Applying Andrew's two following patches solved my problems with time
> skewing.

I can confirm this. Thanks Andrew!!

Regards,
Norberto
