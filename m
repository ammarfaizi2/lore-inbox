Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbVKWSwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbVKWSwj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 13:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbVKWSwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 13:52:39 -0500
Received: from gate.crashing.org ([63.228.1.57]:1249 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932169AbVKWSwi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 13:52:38 -0500
Date: Wed, 23 Nov 2005 12:48:55 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: overlapping resources for platform devices?
In-Reply-To: <20051123115259.GA9560@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0511231245350.4255-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2005, Russell King wrote:

> On Wed, Nov 23, 2005 at 12:57:40AM -0600, Kumar Gala wrote:
> > Any update?
> 
> It should be okay, but I'll step back from saying "safe" because
> I don't particularly like the insert_resource() concept.

Ok. Not sure how to take that.  Would you prefer we work around this some 
other way? or your willing to take a patch but just hesitant about it 
breaking something?

- kumar

