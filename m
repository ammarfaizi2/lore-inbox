Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbTEAAsd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 20:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbTEAAsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 20:48:33 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:56081 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S262591AbTEAAsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 20:48:32 -0400
Date: Thu, 1 May 2003 11:00:43 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] tg3/pci issue with recent 2.5 bk
In-Reply-To: <Mutt.LNX.4.44.0305010232220.18843-100000@excalibur.intercode.com.au>
Message-ID: <Mutt.LNX.4.44.0305011059130.20942-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 May 2003, James Morris wrote:

> > >   Memory behind bridge: fff00000-000fffff
> > >   Prefetchable memory behind bridge: fff00000-000fffff
> > > 
> > > Any hints/suggestions/fixes appreciated.
> > 
> > hmmmm.  Can you look through the 2.5.68 PCI-related csets to see if
> > anything pops up that looks like it's messing with PCI bridge
> > configuration?
> 
> Nope, can't see anything obvious.


It's magically fixed in the bk tree now.  Thanks, whoever did that.


- James
-- 
James Morris
<jmorris@intercode.com.au>

