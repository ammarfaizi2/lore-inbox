Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbUCVAip (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 19:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUCVAip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 19:38:45 -0500
Received: from ns.suse.de ([195.135.220.2]:11460 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261601AbUCVAio (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 19:38:44 -0500
Date: Mon, 22 Mar 2004 01:38:39 +0100
From: Andi Kleen <ak@suse.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.4.26-pre5][x86_64] pci=noapci bogus warning
Message-Id: <20040322013839.7219e85a.ak@suse.de>
In-Reply-To: <200403202310.i2KNA3sp006345@harpo.it.uu.se>
References: <200403202310.i2KNA3sp006345@harpo.it.uu.se>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Mar 2004 00:10:03 +0100 (MET)
Mikael Pettersson <mikpe@csd.uu.se> wrote:

> 2.4.26-pre5 on x86_64 does implement pci=noacpi, but
> using the option triggers a scary message from PCI that
> the option is unknown. (It's really e820.c and ACPI
> that implement it.)

Applied. Thanks.

-Andi
