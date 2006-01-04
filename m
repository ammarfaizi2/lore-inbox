Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964884AbWADRbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbWADRbo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 12:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965244AbWADRbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 12:31:44 -0500
Received: from gate.crashing.org ([63.228.1.57]:7115 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965234AbWADRbn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 12:31:43 -0500
Date: Wed, 4 Jan 2006 11:25:51 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: platform_device_add_resources doesn't request the resources?
In-Reply-To: <20060104172712.GA3119@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0601041123010.32358-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jan 2006, Russell King wrote:

> On Wed, Jan 04, 2006 at 11:07:51AM -0600, Kumar Gala wrote:
> > Is there any reason that platform_device_add_resources doesn't process the 
> > resources that are passed to it like platform_device_add does?
> 
> Yes.  Please dig out the example usage in the change comments which
> introduced it.  The use is clearly explained in there.

Will do so.  Out of interest is there a way to do this with git.  Some 
cross between an annotate command and history.  Give it a line number get 
which commit that was related to and then git the commit message for it.

- kumar

