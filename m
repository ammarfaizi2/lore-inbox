Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbVCJF5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbVCJF5F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 00:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVCJF4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 00:56:09 -0500
Received: from gate.crashing.org ([63.228.1.57]:6089 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261921AbVCJFzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 00:55:25 -0500
Subject: Re: bk commits and dates
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050309194744.6aef66b7.davem@davemloft.net>
References: <1110422519.32556.159.camel@gaston>
	 <20050309194744.6aef66b7.davem@davemloft.net>
Content-Type: text/plain
Date: Thu, 10 Mar 2005 16:50:21 +1100
Message-Id: <1110433821.32524.176.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-09 at 19:47 -0800, David S. Miller wrote:
> On Thu, 10 Mar 2005 13:41:59 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > I don't know if I'm the only one to have a problem with that, but it
> > would be nice if it was possible, when you pull a bk tree, to have the
> > commit messages for the csets in that tree be dated from the day you
> > pulled, and not the day when they went in the source tree.
> 
> When I'm working, I just do "bk csets" after I pull from Linus's
> tree to review what went in since the last time I pulled.

Yes, but the commit list archive is handy. I have quite good search
capabilities in my mailer for example, and sometimes, when doign
regression, it's quite useful to browse what went in between two
releases with it (it's just more handy than bk csets).

Ben.


