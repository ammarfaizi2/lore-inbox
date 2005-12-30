Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbVL3COt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbVL3COt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 21:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbVL3COt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 21:14:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23972 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750777AbVL3COs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 21:14:48 -0500
Date: Thu, 29 Dec 2005 21:14:32 -0500
From: Dave Jones <davej@redhat.com>
To: Jiri Slaby <slaby@liberouter.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Ryan Anderson <ryan@michonline.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: userspace breakage
Message-ID: <20051230021432.GA20371@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jiri Slaby <slaby@liberouter.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Ryan Anderson <ryan@michonline.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20051229073259.GA20177@elte.hu> <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org> <20051229202852.GE12056@redhat.com> <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org> <20051229224103.GF12056@redhat.com> <43B48176.3080509@michonline.com> <20051230004608.GA12822@redhat.com> <Pine.LNX.4.64.0512291702140.3298@g5.osdl.org> <20051230012145.GD12822@redhat.com> <43B49715.9010809@liberouter.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43B49715.9010809@liberouter.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2005 at 03:10:29AM +0100, Jiri Slaby wrote:

 > http://download.fedora.redhat.com/pub/fedora/linux/core/development/SRPMS/
 > [maybe this is the difference?

Of course. development branch always has latest userspace.
The point here is that the old userspace breaks.

		Dave

