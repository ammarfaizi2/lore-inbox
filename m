Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262971AbVGaBFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262971AbVGaBFz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 21:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVGaBFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 21:05:55 -0400
Received: from dsl017-049-110.sfo4.dsl.speakeasy.net ([69.17.49.110]:64911
	"EHLO jm.kir.nu") by vger.kernel.org with ESMTP id S261537AbVGaBFw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 21:05:52 -0400
Date: Sat, 30 Jul 2005 18:04:47 -0700
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Netdev List <netdev@vger.kernel.org>
Subject: Re: [git patches] new wireless stuffs
Message-ID: <20050731010447.GF8195@jm.kir.nu>
References: <42EC0C3E.7030705@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42EC0C3E.7030705@pobox.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2005 at 07:24:46PM -0400, Jeff Garzik wrote:

> One big thing I'm still hoping for is that someone will merge HostAP 
> (where ieee80211 code came from) with the ieee80211 generic code.  The 
> HostAP maintainer has been unwilling to do it, even though he has been 
> good about keeping HostAP updated, so hopefully a volunteer will step up.

I would say this has been more due to lack of time than unwillingness on
my part. Finally, I got git set up yesterday and got back to working
with the wireless-2.6/netdev-2.6 code and I'm planning on working with
the Host AP and ieee80211 code merge. I would expect the client side
functionality to be relatively easy merge, but the AP side functionality
may require considerable amount of work due to the current ieee80211
code being more focused on the client side.

-- 
Jouni Malinen                                            PGP id EFC895FA
