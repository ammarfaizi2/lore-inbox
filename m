Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262761AbVAKAm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262761AbVAKAm0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 19:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262723AbVAKAl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 19:41:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:9353 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262761AbVAKAkD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 19:40:03 -0500
Date: Mon, 10 Jan 2005 16:40:02 -0800
From: Chris Wright <chrisw@osdl.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Steve Bergman <steve@rueb.com>, linux-kernel@vger.kernel.org
Subject: Re: Proper procedure for reporting possible security vulnerabilities?
Message-ID: <20050110164001.Q469@build.pdx.osdl.net>
References: <41E2B181.3060009@rueb.com> <87d5wdhsxo.fsf@deneb.enyo.de> <41E2F6B3.9060008@rueb.com> <Pine.LNX.4.61.0501102309270.2987@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.61.0501102309270.2987@dragon.hygekrogen.localhost>; from juhl-lkml@dif.dk on Mon, Jan 10, 2005 at 11:11:27PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jesper Juhl (juhl-lkml@dif.dk) wrote:
> On Mon, 10 Jan 2005, Steve Bergman wrote:
> > Actually I am having a discussion with a Pax Team member about how the recent
> > exploits discovered by the grsecurity guys should have been handled.  They
> > clam that they sent email to Linus and Andrew and did not receive a response
> > for 3 weeks, and that is why they released exploit code into the wild.
> > 
> > Anyone here have any comments on what I should tell him?
> > 
> I don't know what other people would do or what the general feeling on 
> the list is, but personally I'd send such reports to the maintainer and 
> CC lkml, if there is no maintainer I'd just send to lkml.

Problem is, the rest of the world uses a security contact for reporting
security sensitive bugs to project maintainers and coordinating
disclosures.  I think it would be good for the kernel to do that as well.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
