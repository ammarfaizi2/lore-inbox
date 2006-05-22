Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbWEVSNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWEVSNM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 14:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWEVSNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 14:13:12 -0400
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:61265 "HELO
	smtp112.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751112AbWEVSNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 14:13:11 -0400
Date: Mon, 22 May 2006 11:13:08 -0700
From: Chris Wedgwood <cw@f00f.org>
To: M?ns Rullg?rd <mru@inprovide.com>
Cc: John Levon <levon@movementarian.org>, LKML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, phil.el@wanadoo.fr,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Is OPROFILE actively maintained?
Message-ID: <20060522181308.GA29972@taniwha.stupidest.org>
References: <20060520025322.GD9486@taniwha.stupidest.org> <20060521194915.GA2153@taniwha.stupidest.org> <1148298681.17376.23.camel@localhost.localdomain> <20060522151528.GA20960@totally.trollied.org> <yw1xwtce0x0b.fsf@agrajag.inprovide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1xwtce0x0b.fsf@agrajag.inprovide.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2006 at 06:50:28PM +0100, M?ns Rullg?rd wrote:

> Why should be marked experimental only because of architecture
> limits?  If the parts that can work, work well, there's no reason to
> suggest otherwise.  (Speaking as an Alpha owner)

The only conclusion I can draw from this is that EXPERIMENTAL has no
well defined semantics and as such is essentially pointless.  Everyone
interprets it differently.

I think this is exactly what DaveJ was saying the other day.
