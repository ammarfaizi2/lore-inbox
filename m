Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbUANMmx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 07:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266194AbUANMmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 07:42:53 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:56811 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261298AbUANMms
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 07:42:48 -0500
Date: Wed, 14 Jan 2004 13:42:46 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [3/3] 2.6 broken serial drivers
In-Reply-To: <20040113174219.E7256@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.55.0401141335070.1436@jurand.ds.pg.gda.pl>
References: <Pine.LNX.4.44.0401131148070.18661-100000@eloth>
 <20040113113650.A2975@flint.arm.linux.org.uk> <20040113114948.B2975@flint.arm.linux.org.uk>
 <20040113171544.B7256@flint.arm.linux.org.uk> <20040113174219.E7256@flint.arm.linux.org.uk>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jan 2004, Russell King wrote:

> Here is a patch which updates various serial drivers in the kernel to
> make them less broken than they were before.  Nevertheless, they are
> still broken.
[...]
> ===== drivers/tc/zs.c 1.24 vs edited =====
> --- 1.24/drivers/tc/zs.c	Fri Sep 26 00:38:44 2003
> +++ edited/drivers/tc/zs.c	Tue Jan 13 14:25:30 2004

 Thanks for the patch.  Due to other priorities I have to defer run-time
testing of the driver with 2.6, but I'll have a look at the changes and
make adjustments if they happen to clash with a recent port of fixes from
2.4.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
