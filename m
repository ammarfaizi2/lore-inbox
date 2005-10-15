Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbVJOVGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbVJOVGz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 17:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbVJOVGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 17:06:54 -0400
Received: from ms001msg.fastwebnet.it ([213.140.2.51]:8856 "EHLO
	ms001msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1751220AbVJOVGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 17:06:53 -0400
Date: Sat, 15 Oct 2005 23:03:28 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Nico Schottelius <nico-kernel@schottelius.org>
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Nico Schottelius <nico-kernel@schottelius.org>,
       Christian Kujau <evil@g-house.de>, LKML <linux-kernel@vger.kernel.org>,
       Daniel Aubry <kernel-obri@chaostreff.ch>
Subject: Re: Some problems with 2.6.13.4
Message-ID: <20051015230328.3929264f@localhost>
In-Reply-To: <20051015203824.GN12774@schottelius.org>
References: <20051015122131.GG8609@schottelius.org>
	<43511AB1.3010608@g-house.de>
	<20051015154048.GK8609@schottelius.org>
	<20051015200245.GM12774@schottelius.org>
	<9a8748490510151322w25063287u567ecb698037fc4d@mail.gmail.com>
	<20051015203824.GN12774@schottelius.org>
X-Mailer: Sylpheed-Claws 1.9.13 (GTK+ 2.6.8; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Oct 2005 22:38:24 +0200
Nico Schottelius <nico-kernel@schottelius.org> wrote:

> distcc will fail here, because of different gccs and different distributions
> (ever tried to use gentoo and distcc in the same distcc-network? It's a real
> pain).

You can also use ccache to speed-up:
	http://ccache.samba.org/

-- 
	Paolo Ornati
	Linux 2.6.14-rc4-g7a3ca7d2 on x86_64
