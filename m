Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267952AbTGHXkN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 19:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267954AbTGHXkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 19:40:13 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:38668 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267952AbTGHXkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 19:40:10 -0400
Date: Wed, 9 Jul 2003 00:54:45 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Russell King <rmk@arm.linux.org.uk>
cc: Pavel Machek <pavel@suse.cz>, <vojtech@suse.cz>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Small cleanups for input
In-Reply-To: <20030709005143.G13083@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0307090054240.32323-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Wed, Jul 09, 2003 at 01:32:48AM +0200, Pavel Machek wrote:
> > So perhaps we need to add machine_suspend_ram() and
> > machine_suspend_disk() to reboot.h? We *do* want to have some generic
> > interface...
> 
> Sounds good.

This would be really nice :-) Very handy for PDAs.


