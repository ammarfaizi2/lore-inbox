Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264886AbUGIOlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264886AbUGIOlP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 10:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264906AbUGIOlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 10:41:15 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:49924 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264886AbUGIOlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 10:41:12 -0400
Subject: Re: 2.6.7-mm7
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1089369159.3198.4.camel@paragon.slim>
References: <20040708235025.5f8436b7.akpm@osdl.org>
	 <1089369159.3198.4.camel@paragon.slim>
Content-Type: text/plain
Date: Fri, 09 Jul 2004 16:40:59 +0200
Message-Id: <1089384059.1742.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.2 (1.5.9.2-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have you tried reverting bk-usb? 2.6.7-mm7 won't work for me without
reverting it.

On Fri, 2004-07-09 at 12:32 +0200, Jurgen Kramer wrote:
> On Fri, 2004-07-09 at 08:50, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm7/
> > 
> My EHCI controller still won't come back to life. I have tried 
> various boot options to no avail. I still gives:

