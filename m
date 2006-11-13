Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933141AbWKMXHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933141AbWKMXHu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 18:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933139AbWKMXHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 18:07:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56452 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933141AbWKMXHt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 18:07:49 -0500
Date: Mon, 13 Nov 2006 15:06:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, Jeff Garzik <jeff@garzik.org>,
       Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: linux-2.6.19-rc5-g088406bc build #120 failed
Message-Id: <20061113150616.5bd122ae.akpm@osdl.org>
In-Reply-To: <4558E652.1080905@microgate.com>
References: <200611130943.42463.toralf.foerster@gmx.de>
	<4558860B.8090908@garzik.org>
	<45588895.7010501@microgate.com>
	<m3ejs78adt.fsf@defiant.localdomain>
	<4558BF72.2030408@microgate.com>
	<m3ac2v6phw.fsf@defiant.localdomain>
	<4558E652.1080905@microgate.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2006 15:40:34 -0600
Paul Fulghum <paulkf@microgate.com> wrote:

> I know code is open to criticism,
> but after several weeks of submitting patches
> and getting no closer to acceptance I gave up.
> We were going around in circles where one person
> wanted some thing that conflicted with what
> another person wanted.

That happens sometimes.

I'd suggest that you send what you believe to be the correct change and see
if you can preempt the usual objections via the changelog.

I wouldn't say it's a high-priority thing, btw.  There are surely plenty of
won't-link config settings and few people are hurting from this one.

