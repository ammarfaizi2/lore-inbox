Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263887AbTDYL6u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 07:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263892AbTDYL6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 07:58:50 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:60614 "EHLO gaston")
	by vger.kernel.org with ESMTP id S263887AbTDYL6t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 07:58:49 -0400
Subject: Re: Update to orinoco driver (2.4)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <hermes@gibson.dropbear.id.au>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Jean Tourrilhes <jt@hpl.hp.com>, David Hinds <dhinds@sonic.net>
In-Reply-To: <20030423060520.GI25455@zax>
References: <20030423054636.GG25455@zax>  <20030423060520.GI25455@zax>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051272644.15776.2.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 25 Apr 2003 14:10:45 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-23 at 08:05, David Gibson wrote:
> On Wed, Apr 23, 2003 at 03:46:36PM +1000, David Gibson wrote:
> > Hi Marcelo,
> > 
> > The patch below updates the orinoco driver in 2.4 to 0.13d, the patch
> > is against 2.4.21-rc1.  You may want to postpone this update till
> > after 2.4.21, but I'd consider it, since it fixes a fair slew of bugs.
> 
> Duh, sorry.  And now with the actual patch:

Shouldn't it also patch Config.in & Makefile to add the orinoco_tmd.c ?

I'm adding this new driver to my pmac bk tree btw.

Ben.

