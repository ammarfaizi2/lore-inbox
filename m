Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264365AbUFKWMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264365AbUFKWMY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 18:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264367AbUFKWMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 18:12:24 -0400
Received: from gate.crashing.org ([63.228.1.57]:17588 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264365AbUFKWMV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 18:12:21 -0400
Subject: Re: [PATCH][RFC] Spinlock-timeout
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: moilanen@austin.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>,
       Jan-Benedict Glaw <jbglaw@lug-owl.de>
In-Reply-To: <Pine.A41.4.44.0406111620061.68840-100000@forte.austin.ibm.com>
References: <Pine.A41.4.44.0406111620061.68840-100000@forte.austin.ibm.com>
Content-Type: text/plain
Message-Id: <1086991759.2711.27.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 11 Jun 2004 17:09:20 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Here's the ppc64 add-on for using timebase register for the spinlock
> timeout.  If no one has any issues w/ the base spin-lock timeout patch, or
> this one, please apply.

Same comment, make sure you produce a unified diff.

Ben.


