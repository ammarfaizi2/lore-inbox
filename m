Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263708AbTIHWlI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 18:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263697AbTIHWlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 18:41:07 -0400
Received: from imap.comunit.de ([193.103.160.193]:63469 "EHLO imap.comunit.de")
	by vger.kernel.org with ESMTP id S263708AbTIHWko (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 18:40:44 -0400
Date: Tue, 9 Sep 2003 00:40:41 +0200 (CEST)
From: Sven-Haegar Koch <haegar@sdinet.de>
X-X-Sender: haegar@space.comunit.de
To: Jeff Garzik <jgarzik@pobox.com>
Cc: netdev@oss.sgi.com, "David S. Miller" <davem@redhat.com>,
       Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: ifconfig up/down problem
In-Reply-To: <3F5CFF7E.1090005@pobox.com>
Message-ID: <Pine.LNX.4.56.0309090039210.28325@space.comunit.de>
References: <Pine.LNX.4.56.0309090004100.24700@space.comunit.de>
 <3F5CFF7E.1090005@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Sep 2003, Jeff Garzik wrote:

> Sven-Haegar Koch wrote:
> > Short: ifconfig ethX down locks
> Does the attached patch fix it?

Yes, it does - thanks a lot!

c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)
