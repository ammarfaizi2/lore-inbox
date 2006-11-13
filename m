Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933155AbWKMXMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933155AbWKMXMz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 18:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933153AbWKMXMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 18:12:55 -0500
Received: from xenotime.net ([66.160.160.81]:50608 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S933152AbWKMXMy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 18:12:54 -0500
Date: Mon, 13 Nov 2006 15:13:01 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Paul Fulghum <paulkf@microgate.com>, Jeff Garzik <jeff@garzik.org>,
       Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Re: linux-2.6.19-rc5-g088406bc build #120 failed
Message-Id: <20061113151301.40e6964d.rdunlap@xenotime.net>
In-Reply-To: <m3psbr54nb.fsf@defiant.localdomain>
References: <200611130943.42463.toralf.foerster@gmx.de>
	<4558860B.8090908@garzik.org>
	<45588895.7010501@microgate.com>
	<m3ejs78adt.fsf@defiant.localdomain>
	<4558BF72.2030408@microgate.com>
	<m3ac2v6phw.fsf@defiant.localdomain>
	<4558E652.1080905@microgate.com>
	<m3psbr54nb.fsf@defiant.localdomain>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2006 00:05:28 +0100 Krzysztof Halasa wrote:

> Paul Fulghum <paulkf@microgate.com> writes:
> 
> > To be more precise, that is many distinct
> > criticisms from distinct people, some of which
> > contradict each other.
> 
> That's not exactly how I remember it.
> 
> See Andrew's mail http://lkml.org/lkml/2006/6/7/257. For me, your
> response(s) meant the problem was solved (so it wans't a dream :-) ).
> 
> For reference, the original patch which was almost accepted was
> http://lkml.org/lkml/2006/6/7/111.
> 
> Kconfig patches were clearly a dead end, Randy hadn't realized HDLC
> is optional for the synclink drivers.

Correct.

---
~Randy
