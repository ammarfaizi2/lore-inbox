Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbVCMVhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbVCMVhm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 16:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVCMVhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 16:37:42 -0500
Received: from ipx10069.ipxserver.de ([80.190.240.67]:8426 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id S261464AbVCMVhi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 16:37:38 -0500
Date: Sun, 13 Mar 2005 22:30:55 +0100
From: Felix von Leitner <felix-linuxkernel@fefe.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.11: USB broken on nforce4, ipv6 still broken, centrino speedstep even more broken than in 2.6.10
Message-ID: <20050313213055.GA16224@codeblau.de>
References: <20050311202122.GA13205@fefe.de> <20050311173233.462971be.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050311173233.462971be.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spake Andrew Morton (akpm@osdl.org):
> > My new nForce 4 mainboard has 10 or so USB 2.0 outlets.  In Windows,
> > they all work.  In Linux, two of them work.  Putting my USB stick or
> > anything else in one of the others produces nothing in Linux.
> > Apparently no IRQ getting through or something?

> Did it work correctly on any earlier kernel?  If so, which one(s)?

It turns out the ports do work with 2.6.11; I was running rc4 when I
last observed it break.

Sorry for the bad bug report.

Felix
