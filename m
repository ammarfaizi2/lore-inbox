Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263276AbTEMIh3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 04:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263282AbTEMIh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 04:37:29 -0400
Received: from 7.Red-80-37-235.pooles.rima-tde.net ([80.37.235.7]:16366 "EHLO
	pau.intranet.ct") by vger.kernel.org with ESMTP id S263276AbTEMIh1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 04:37:27 -0400
Date: Tue, 13 May 2003 10:49:47 +0200 (CEST)
From: Pau Aliagas <linuxnow@newtral.org>
X-X-Sender: pau@pau.intranet.ct
To: lkml <linux-kernel@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>
Subject: Re: no console found booting 2.5.69
In-Reply-To: <20030509231105.D5204@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0305131048430.1574-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 May 2003, Russell King wrote:

> On Fri, May 09, 2003 at 06:47:59PM +0200, Pau Aliagas wrote:
> > Another problem is the PCMCIA that I already reported for 2.5.68; it 
> > stalls if I don't remove the Cardbus card.
> 
> I never got around to sending the patch because I only received one
> report.  Please try the patch found at:
> 
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=105162599105406&w=2

I get plenty of rejects in 2.5.69. Do you have a newer version for it to 
test?

Pau

