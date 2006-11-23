Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933577AbWKWKyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933577AbWKWKyE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 05:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933580AbWKWKyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 05:54:04 -0500
Received: from colin.muc.de ([193.149.48.1]:16901 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S933577AbWKWKyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 05:54:02 -0500
Date: 23 Nov 2006 11:54:00 +0100
Date: Thu, 23 Nov 2006 11:54:00 +0100
From: Andi Kleen <ak@muc.de>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
       Kumar Gala <galak@kernel.crashing.org>,
       Kim Phillips <kim.phillips@freescale.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, akpm@osdl.org,
       davem@davemloft.net, kkojima@rr.iij4u.or.jp, lethal@linux-sh.org,
       paulus@samba.org, ralf@linux-mips.org, rmk@arm.linux.org.uk
Subject: Re: NTP time sync
Message-ID: <20061123105400.GA75714@muc.de>
References: <20061122203633.611acaa8@inspiron>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061122203633.611acaa8@inspiron>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [1] http://lkml.org/lkml/2006/3/28/358

What was the answer to Matt's last question in there?
If the existing user land does it already then 
probably.  If not then a good migration strategy would 
be needed.

-Andi
