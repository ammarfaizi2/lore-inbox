Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266145AbUFUHVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266145AbUFUHVe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 03:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266138AbUFUHVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 03:21:25 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:24836 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S266145AbUFUHUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 03:20:54 -0400
Subject: Re: 2.6.7-bk way too fast
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Ricky Beam <jfbeam@bluetronic.net>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.33.0406202320020.25702-100000@sweetums.bluetronic.net>
References: <Pine.GSO.4.33.0406202320020.25702-100000@sweetums.bluetronic.net>
Content-Type: text/plain
Date: Mon, 21 Jun 2004 09:20:44 +0200
Message-Id: <1087802444.1691.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 (1.5.9.1-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-06-20 at 23:29 -0400, Ricky Beam wrote:
> On Sun, 20 Jun 2004, Jeff Garzik wrote:
> >Something is definitely screwy with the latest -bk.
> 
> I'm not seeing any troubles...

I'm only seeing this behavior in one of my machines. One is a laptop,
which doesn't suffer from this slew, the other one is a desktop system,
which suffers from it. Both are using ACPI, but only the desktop system
is usign APIC/IO-APIC.

I can post both configs, if useful.

