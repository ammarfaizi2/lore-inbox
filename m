Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933135AbWKMXFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933135AbWKMXFb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 18:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933137AbWKMXFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 18:05:31 -0500
Received: from khc.piap.pl ([195.187.100.11]:2733 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S933135AbWKMXFa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 18:05:30 -0500
To: Paul Fulghum <paulkf@microgate.com>
Cc: Jeff Garzik <jeff@garzik.org>,
       Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Re: linux-2.6.19-rc5-g088406bc build #120 failed
References: <200611130943.42463.toralf.foerster@gmx.de>
	<4558860B.8090908@garzik.org> <45588895.7010501@microgate.com>
	<m3ejs78adt.fsf@defiant.localdomain> <4558BF72.2030408@microgate.com>
	<m3ac2v6phw.fsf@defiant.localdomain> <4558E652.1080905@microgate.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 14 Nov 2006 00:05:28 +0100
In-Reply-To: <4558E652.1080905@microgate.com> (Paul Fulghum's message of "Mon, 13 Nov 2006 15:40:34 -0600")
Message-ID: <m3psbr54nb.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Fulghum <paulkf@microgate.com> writes:

> To be more precise, that is many distinct
> criticisms from distinct people, some of which
> contradict each other.

That's not exactly how I remember it.

See Andrew's mail http://lkml.org/lkml/2006/6/7/257. For me, your
response(s) meant the problem was solved (so it wans't a dream :-) ).

For reference, the original patch which was almost accepted was
http://lkml.org/lkml/2006/6/7/111.

Kconfig patches were clearly a dead end, Randy hadn't realized HDLC
is optional for the synclink drivers.
-- 
Krzysztof Halasa
