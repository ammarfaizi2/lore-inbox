Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbTD3QU5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 12:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbTD3QU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 12:20:57 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:14608 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S261189AbTD3QU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 12:20:56 -0400
Date: Thu, 1 May 2003 02:32:55 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] tg3/pci issue with recent 2.5 bk
In-Reply-To: <20030430155125.GF25076@gtf.org>
Message-ID: <Mutt.LNX.4.44.0305010232220.18843-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Apr 2003, Jeff Garzik wrote:

> > The difference between the two is for the PCI bridge, which is missing the 
> > following lines in the output for the bk kernel.
> > 
> >   Memory behind bridge: fff00000-000fffff
> >   Prefetchable memory behind bridge: fff00000-000fffff
> > 
> > Any hints/suggestions/fixes appreciated.
> 
> hmmmm.  Can you look through the 2.5.68 PCI-related csets to see if
> anything pops up that looks like it's messing with PCI bridge
> configuration?

Nope, can't see anything obvious.


- James
-- 
James Morris
<jmorris@intercode.com.au>

