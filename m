Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262662AbVBYKIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262662AbVBYKIZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 05:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262664AbVBYKIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 05:08:24 -0500
Received: from aun.it.uu.se ([130.238.12.36]:63918 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262662AbVBYKIW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 05:08:22 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16926.63745.143566.413488@alkaid.it.uu.se>
Date: Fri, 25 Feb 2005 11:08:01 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ppc32 weirdness with gcc-4.0 in 2.6.11-rc4
In-Reply-To: <20050224160139.GF853@devserv.devel.redhat.com>
References: <16924.59237.581247.498382@alkaid.it.uu.se>
	<1109210688.15027.2.camel@gaston>
	<16925.60927.49095.758660@alkaid.it.uu.se>
	<20050224160139.GF853@devserv.devel.redhat.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek writes:
 > On Thu, Feb 24, 2005 at 04:08:47PM +0100, Mikael Pettersson wrote:
 > > _However_, the 0k data message is due to a gcc-4.0 bug, and below
 > > you'll find a test program which illustrates it.
 > 
 > http://gcc.gnu.org/PR20196

Jakub's patch to gcc4 solved the mysterious "0k data" message,
but my eMac's USB is still dysfunctional. I'll try to look into
that next week.

/Mikael
