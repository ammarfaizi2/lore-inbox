Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262830AbVAKQ6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262830AbVAKQ6E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 11:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262825AbVAKQ52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 11:57:28 -0500
Received: from mail.dif.dk ([193.138.115.101]:1985 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262830AbVAKQzM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 11:55:12 -0500
Date: Tue, 11 Jan 2005 17:57:41 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Diego Calleja <diegocg@gmail.com>, Steve Bergman <steve@rueb.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Proper procedure for reporting possible security vulnerabilities?
In-Reply-To: <20050111001901.GA4378@ip68-4-98-123.oc.oc.cox.net>
Message-ID: <Pine.LNX.4.61.0501111754400.3368@dragon.hygekrogen.localhost>
References: <41E2B181.3060009@rueb.com> <87d5wdhsxo.fsf@deneb.enyo.de>
 <41E2F6B3.9060008@rueb.com> <20050110230827.4d13ae7b.diegocg@gmail.com>
 <20050111001901.GA4378@ip68-4-98-123.oc.oc.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2005, Barry K. Nathan wrote:

> On Mon, Jan 10, 2005 at 11:08:27PM +0100, Diego Calleja wrote:
> > They could have mailed to *THIS* mailing list, so anyone can make a patch.
> 
> And abandon the whole idea of coordinated disclosure? That would put

Not everyone agrees that that is the proper way to do things, some prefer 
full disclosure.
Personally I'd prefer full disclosure on a public mailing list (copying 
vendors, maintainers etc of course), so as many people as possible can get 
to work on a fix as soon as possible. Keeping things secret doesn't speed 
up the time to get a fix made.

-- 
Jesper Juhl

