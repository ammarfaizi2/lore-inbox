Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVAKR7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVAKR7N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 12:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbVAKR62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 12:58:28 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:49108 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261352AbVAKRnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 12:43:49 -0500
Subject: Re: Proper procedure for reporting possible security
	vulnerabilities?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Chris Wright <chrisw@osdl.org>, Steve Bergman <steve@rueb.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0501111758290.3368@dragon.hygekrogen.localhost>
References: <41E2B181.3060009@rueb.com> <87d5wdhsxo.fsf@deneb.enyo.de>
	 <41E2F6B3.9060008@rueb.com>
	 <Pine.LNX.4.61.0501102309270.2987@dragon.hygekrogen.localhost>
	 <20050110164001.Q469@build.pdx.osdl.net>
	 <Pine.LNX.4.61.0501111758290.3368@dragon.hygekrogen.localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105461562.16168.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 11 Jan 2005 16:39:23 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-01-11 at 17:05, Jesper Juhl wrote:
> Problem is that the info can then get stuck at a vendor or maintainer 
> outside of public view and risk being mothballed. It also limits the 
> number of people who can work on a solution (including peole getting to 
> work on auditing other code for similar issues). It also prevents admins 
> from taking alternative precautions prior to availability of a fix (you 
> have to assume the bad guys already know of the bug, not just the good 
> guys).

The evidence is that for the most part the bad guys don't know about the
bug and the majority of the bad guys are not skilled enough to write
some of the complex exploits. They also automate extensively so given an
exploit can make very fast very effective use of it. There is an entire
field of economics and game theory tied up in this as well as papers by
some in the field who look at computer security models this way.

If you are a member of the full disclosure camp then fine, but please cc
vendor-sec when you publish the hole just in case Linus loses the email
and so vendors know too and can plan appropriately.

Alan

