Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262586AbVAJWSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262586AbVAJWSY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 17:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262565AbVAJWOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 17:14:23 -0500
Received: from mail.dif.dk ([193.138.115.101]:2763 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262719AbVAJWJA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 17:09:00 -0500
Date: Mon, 10 Jan 2005 23:11:27 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve Bergman <steve@rueb.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Proper procedure for reporting possible security vulnerabilities?
In-Reply-To: <41E2F6B3.9060008@rueb.com>
Message-ID: <Pine.LNX.4.61.0501102309270.2987@dragon.hygekrogen.localhost>
References: <41E2B181.3060009@rueb.com> <87d5wdhsxo.fsf@deneb.enyo.de>
 <41E2F6B3.9060008@rueb.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2005, Steve Bergman wrote:

> Florian Weimer wrote:
> 
> > Contact your vendor.  You are using vendor kernels, are you? 8-)
> >  
> 
> Actually I am having a discussion with a Pax Team member about how the recent
> exploits discovered by the grsecurity guys should have been handled.  They
> clam that they sent email to Linus and Andrew and did not receive a response
> for 3 weeks, and that is why they released exploit code into the wild.
> 
> Anyone here have any comments on what I should tell him?
> 
I don't know what other people would do or what the general feeling on 
the list is, but personally I'd send such reports to the maintainer and 
CC lkml, if there is no maintainer I'd just send to lkml.

-- 
Jesper Juhl

