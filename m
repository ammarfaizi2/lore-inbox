Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264437AbTGBTPn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 15:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264456AbTGBTPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 15:15:43 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:61854 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S264437AbTGBTPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 15:15:42 -0400
Date: Wed, 2 Jul 2003 16:25:05 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Adrian Bunk <bunk@fs.tum.de>, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [2.4 patch] netfilter Configure.help cleanup 
In-Reply-To: <20030630051516.AAEC12C220@lists.samba.org>
Message-ID: <Pine.LNX.4.55L.0307021624510.17865@freak.distro.conectiva>
References: <20030630051516.AAEC12C220@lists.samba.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Make that go through davem, please.

On Mon, 30 Jun 2003, Rusty Russell wrote:

> In message <20030627233357.GN24661@fs.tum.de> you write:
> > - remove useless short descriptions above CONFIG_*
>
> > -Connection tracking (required for masq/NAT)
> >  CONFIG_IP_NF_CONNTRACK
>
> Can you really do this?  A quick skim didn't find anyone else skipping
> this line...
>
> Thanks,
> Rusty.
> --
>   Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
>
