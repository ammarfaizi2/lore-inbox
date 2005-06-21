Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbVFUUIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbVFUUIT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 16:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbVFUUH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 16:07:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62861 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261474AbVFUUGe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 16:06:34 -0400
Date: Tue, 21 Jun 2005 13:02:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, jbenc@suse.cz,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: -mm -> 2.6.13 merge status (wireless)
Message-Id: <20050621130250.78759088.akpm@osdl.org>
In-Reply-To: <20050621141930.GB2015@openzaurus.ucw.cz>
References: <20050620235458.5b437274.akpm@osdl.org>
	<20050621141930.GB2015@openzaurus.ucw.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
> 
> > This summarises my current thinking on various patches which are presently
> > in -mm.  I cover large things and small-but-controversial things.  Anything
> > which isn't covered here (and that's a lot of material) is probably a "will
> > merge", unless it obviously isn't.
> 
> I'd like to ask about 802.11 stack and ipw2100 in particular... Is it
> "small enough that it did not need mentioning"?
> Working wireless in mainline would be great...

That's up to Jeff.
