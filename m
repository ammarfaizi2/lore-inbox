Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWEVPdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWEVPdE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 11:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbWEVPdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 11:33:04 -0400
Received: from smtp102.sbc.mail.mud.yahoo.com ([68.142.198.201]:10904 "HELO
	smtp102.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750701AbWEVPdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 11:33:02 -0400
Date: Mon, 22 May 2006 08:27:33 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       levon@movementarian.org, phil.el@wanadoo.fr,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Is OPROFILE actively maintained?
Message-ID: <20060522152733.GB8228@taniwha.stupidest.org>
References: <20060520025322.GD9486@taniwha.stupidest.org> <20060521194915.GA2153@taniwha.stupidest.org> <1148298681.17376.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148298681.17376.23.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2006 at 12:51:21PM +0100, Alan Cox wrote:

> By which theory we should ditch ia-64 while we are at it.

ia64 is used, fairly well tested and has a large body of people
working on it

if the code isn't to your liking then I'm sure the people involved
are open to your constructive comments

> Be serious, oprofile is good working code, even if you have some
> personal problem with it.

Yes, oprofile does work, I use it myself.  So the core issue is really
whether it should be EXPERIMENTAL or not then.

I've sorta come to the concluusion the EXPERIMENTAL is basically
pointless, it hides too many useful things.
