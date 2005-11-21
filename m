Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbVKUQvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbVKUQvU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 11:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbVKUQvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 11:51:20 -0500
Received: from havoc.gtf.org ([69.61.125.42]:43735 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751054AbVKUQvT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 11:51:19 -0500
Date: Mon, 21 Nov 2005 11:51:18 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Rob Landley <rob@landley.net>
Cc: asmith@vtrl.co.uk, linux-kernel@vger.kernel.org
Subject: Re: Does Linux support powering down SATA drives?
Message-ID: <20051121165118.GB1511@havoc.gtf.org>
References: <437F63C1.6010507@perkel.com> <200511192304.16302.s0348365@sms.ed.ac.uk> <Pine.LNX.4.61.0511200718530.25549@vtrl22.vtrl.co.uk> <200511211021.21939.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511211021.21939.rob@landley.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 10:21:21AM -0600, Rob Landley wrote:
> On Sunday 20 November 2005 01:22, asmith@vtrl.co.uk wrote:
> > I would agree with your view on IDE becoming obsolete on hard drives, but I
> > as yet, am not aware of any CD/DVD drives with a SATA interface.
> 
> Laptops?

Laptops will likely get S/ATAPI later rather than sooner.

But there are definitely S/ATAPI devices out there.  Most are first
generation, which means they are PATA devices with a SATA bridge (thus
they appear to the end user to be SATA).

	Jeff



