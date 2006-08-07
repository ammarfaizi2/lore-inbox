Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWHGTX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWHGTX5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 15:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbWHGTX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 15:23:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26025 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750830AbWHGTXz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 15:23:55 -0400
Date: Mon, 7 Aug 2006 12:23:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Shem Multinymous <multinymous@gmail.com>, rlove@rlove.org,
       khali@linux-fr.org, gregkh@suse.de, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 01/12] thinkpad_ec: New driver for ThinkPad embedded
 controller access
Message-Id: <20060807122319.ed93110a.akpm@osdl.org>
In-Reply-To: <20060807132628.GC4032@ucw.cz>
References: <11548492171301-git-send-email-multinymous@gmail.com>
	<11548492242899-git-send-email-multinymous@gmail.com>
	<20060806005613.01c5a56a.akpm@osdl.org>
	<41840b750608060256g1a7bb9c3s843d3ac08e512d63@mail.gmail.com>
	<20060806030749.ab49c887.akpm@osdl.org>
	<20060807132628.GC4032@ucw.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Aug 2006 13:26:29 +0000
Pavel Machek <pavel@suse.cz> wrote:

> Hi!
> 
> > > What more is needed that may be realistically expected from a kernel
> > > patch submission?
> > 
> > We who accept the submission would be making a joke of the whole thing if
> > we accepted the assurances of a person who is concealing his/her identity.
> > 
> > I suggested a simple solution: Perhaps one of the other project members
> > (ie: one who uses a real name) could also sign off the patches?
> 
> I'm willing to sign off these patches. (In legal sense, anyway. I have
> not yet went through them carefully).
> 

Thanks.  So this will amount to Pavel asserting that this code is kosher,
based upon the knowledge which you've gained from participating in this
project.

I'll run that by Linus when he resurfaces.

And I'll duck this version of the patch series due to your code review
comments.  Please cc me on version 2.
