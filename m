Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264530AbUGBN6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264530AbUGBN6Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 09:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbUGBN6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 09:58:25 -0400
Received: from dyn-83-152-117-254.ppp.tiscali.fr ([83.152.117.254]:29710 "EHLO
	nsbm.kicks-ass.org") by vger.kernel.org with ESMTP id S264530AbUGBN6Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 09:58:24 -0400
Date: Fri, 2 Jul 2004 06:56:45 +0200
From: Witukind <witukind@nsbm.kicks-ass.org>
To: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Voodoo3 2000 is eating my chars!
Message-Id: <20040702065645.27e93ac3.witukind@nsbm.kicks-ass.org>
In-Reply-To: <20040702073636.GA25592@babylon.d2dc.net>
References: <20040701185527.GB122@DervishD>
	<20040702073636.GA25592@babylon.d2dc.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jul 2004 03:36:36 -0400
"Zephaniah E. Hull" <warp@babylon.d2dc.net> wrote:

> On Thu, Jul 01, 2004 at 08:55:27PM +0200, DervishD wrote:
> >     Hi all :)
> > 
> >     I recently put a Voodoo3 2000 (AGP) card to my home linux box,
> > and now I have a problem in the console. When switching from X to
> > the console, some chars dissappear, or appear cut, etc. I've googled
> > for this, but with no success. Is this a known bug? Maybe an X bug?
> 
> This is actually an X bug, which I thought I had fixed a long time ago
> when I was still doing 3Dfx stuff.
> 
> On console switch not all the state is being restored properly,
> specificly the font is getting screwed up, simply reloading the font
> should work fine though.
> 
> I no longer have either an X tree to easily play in, nor a 3Dfx card
> in a box to test with, so I'm afraid that you're going to have to bug
> the X people.

Same behavior here with Voodoo 3 2000 PCI. I just quickly switch back to X and back to the
console to get the font right, it'll mess up a character or two only quite rarely though, at most 10% of the times
when I switch. I'm not even sure it happened yet since I upgraded to XFree86 4.4.0, but I'm not 100% positive on
this.
