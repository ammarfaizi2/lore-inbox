Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263635AbUC3MiF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 07:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbUC3MiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 07:38:04 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:19462 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S263635AbUC3MiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 07:38:03 -0500
Subject: Re: Linux 2.6.5-rc3
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Dominik Karall <dominik.karall@gmx.net>,
       Ivan Gyurdiev <ivg2@cornell.edu>
In-Reply-To: <200403301026.09039@WOLK>
References: <Pine.LNX.4.58.0403292129200.1096@ppc970.osdl.org>
	 <40690B84.7060203@cornell.edu> <200403300814.21205.dominik.karall@gmx.net>
	 <200403301026.09039@WOLK>
Content-Type: text/plain
Message-Id: <1080650274.1134.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Tue, 30 Mar 2004 14:37:54 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-30 at 10:26, Marc-Christian Petersen wrote:
> On Tuesday 30 March 2004 08:14, Dominik Karall wrote:
> 
> Hi Dominik,
> 
> > Take a look in your config file, if 4KSTACK is enabled, it shouldn't.
> 
> err, we are talking about 2.6.5-rc3, not 2.6.5-rc*-mm* :p

What about CONFIG_REGPARM? Did you enable it?

