Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265831AbUGDWhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265831AbUGDWhb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 18:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265828AbUGDWha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 18:37:30 -0400
Received: from outmx009.isp.belgacom.be ([195.238.3.4]:40068 "EHLO
	outmx009.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S265831AbUGDWh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 18:37:28 -0400
Subject: Re: procfs permissions on 2.6.x
From: FabF <fabian.frederick@skynet.be>
To: Andi Kleen <ak@muc.de>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
In-Reply-To: <m34qone7f6.fsf@averell.firstfloor.org>
References: <2dZjc-7BP-15@gated-at.bofh.it> <2dZjf-7BP-27@gated-at.bofh.it>
	 <2dZsQ-7GF-23@gated-at.bofh.it> <2dZVV-867-33@gated-at.bofh.it>
	 <2e0oZ-8lm-35@gated-at.bofh.it> <2emSs-6R8-17@gated-at.bofh.it>
	 <2enbS-72q-19@gated-at.bofh.it> <2env9-7li-9@gated-at.bofh.it>
	 <m34qone7f6.fsf@averell.firstfloor.org>
Content-Type: text/plain
Message-Id: <1088980642.2429.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 05 Jul 2004 00:37:22 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-05 at 00:25, Andi Kleen wrote:
> viro@parcelfarce.linux.theplanet.co.uk writes:
> >
> > Why on the earth do we ever want to allow chown/chmod on procfs in the first
> > place?
> 
> It's useful to stop other people from reading your environment
> or command line.
We wouldn't need that feature if mods are accurately defined from the
beginning (ie at creation) at that's already the case AFAICS.

FabF

