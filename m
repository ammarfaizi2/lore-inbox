Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269578AbTGUJ7s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 05:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269583AbTGUJ7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 05:59:48 -0400
Received: from mta6-svc.business.ntl.com ([62.253.164.46]:62600 "EHLO
	mta6-svc.business.ntl.com") by vger.kernel.org with ESMTP
	id S269578AbTGUJ7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 05:59:47 -0400
Date: Mon, 21 Jul 2003 11:16:20 +0100 (BST)
From: William Gallafent <william.gallafent@virgin.net>
X-X-Sender: williamg@officebedroom.oldvicarage
To: Roger Luethi <rl@hellgate.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APIC support prevents power off
In-Reply-To: <20030721095414.GA3865@k3.hellgate.ch>
Message-ID: <Pine.LNX.4.53.0307211111470.3789@officebedroom.oldvicarage>
References: <200307210113.h6L1DqiY018985@harpo.it.uu.se>
 <20030721095414.GA3865@k3.hellgate.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mon, 21 Jul 2003 03:13:52 +0200, Mikael Pettersson wrote:

> > - ensure you have the latest BIOS

On Mon, 21 Jul 2003, Roger Luethi wrote:

> I tend not to touch the BIOS unless I have reason to believe an update will
> fix an actual problem.

FWIW, Updating the BIOS on my Tyan Tiger MP did sort out some (I *think* APIC
related) problems I had with a PCI ethernet card under 2.4.18. I agree with
your `if it ain't broke don't fix it' approach in general, but in this case
updating the BIOS fixed for me a problem that I had not attributed to it!

-- 
Bill Gallafent.
