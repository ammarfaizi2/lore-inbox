Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbTJAU15 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 16:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262474AbTJAU15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 16:27:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:4527 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262409AbTJAU14 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 16:27:56 -0400
Date: Wed, 1 Oct 2003 13:27:41 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Muli Ben-Yehuda <mulix@mulix.org>
cc: J?rn Engel <joern@wohnheim.fh-wedel.de>, <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] CONFIG_* In Comments Considered Harmful
In-Reply-To: <20031001201552.GR729@actcom.co.il>
Message-ID: <Pine.LNX.4.44.0310011326260.838-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 1 Oct 2003, Muli Ben-Yehuda wrote:
> 
> Looks like this patch made it past Linus's famous patch barriers and

Or "infamous"?

I apply obvious typos to comments without really worrying about them too
much ;)

> (Linus, if you want to fix it by hand, just deleted the
> CONFIG_HIGHMEM bit completely from the #endif line).

Done.

		Linus

