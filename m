Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264665AbUIVLvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264665AbUIVLvy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 07:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264704AbUIVLvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 07:51:54 -0400
Received: from imap.gmx.net ([213.165.64.20]:39349 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264665AbUIVLvx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 07:51:53 -0400
X-Authenticated: #1725425
Date: Wed, 22 Sep 2004 13:55:49 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: root@chaos.analogic.com
Cc: rusty@rustcorp.com.au, torvalds@osdl.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       davem@davemloft.net
Subject: Re: [PATCH] Warn people that ipchains and ipfwadm are going away.
Message-Id: <20040922135549.47fabe49.Ballarin.Marc@gmx.de>
In-Reply-To: <Pine.LNX.4.53.0409220735080.2066@chaos.analogic.com>
References: <1095721742.5886.128.camel@bach>
	<20040921143613.2dc78e2f.Ballarin.Marc@gmx.de>
	<1095803902.1942.211.camel@bach>
	<Pine.LNX.4.53.0409220735080.2066@chaos.analogic.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sep 2004 07:36:47 -0400 (EDT)
"Richard B. Johnson" <root@chaos.analogic.com> wrote:

> 
> What replaces the firewall stuff? It can't just "go away"!

In the upcoming kernel 2.4, which will be released January 2001, iptables
will replace ipchains.

Regards
