Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265076AbTFUEqw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 00:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265082AbTFUEqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 00:46:51 -0400
Received: from beta.galatali.com ([216.40.241.205]:10644 "EHLO
	beta.galatali.com") by vger.kernel.org with ESMTP id S265076AbTFUEqv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 00:46:51 -0400
Subject: 2.5.72 + ACPI 20030619 still won't boot (was Re: 2.5.71 won't
	boot, ACPI related)
From: Tugrul Galatali <tugrul@galatali.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1055704641.564.8.camel@duality.galatali.com>
References: <1055704641.564.8.camel@duality.galatali.com>
Content-Type: text/plain
Message-Id: <1056171651.349.2.camel@duality.galatali.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 21 Jun 2003 01:00:51 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	.72 and .72 + ACPI 20030619 patch both still fail with what appears to
be the same error.

	Tugrul Galatali

On Sun, 2003-06-15 at 15:17, Tugrul Galatali wrote:
> 	Both .70 and .71, with the new ACPI rev, stop booting after spitting
> out the following lines (transcribed by hand):
> 
> ACPI: Subsystem revision 20030522
>     ACPI-0183: *** Error: Looking up [\_SB_.PCI0.LPC_.ECP0] in namespace, AE_NOT_FOUND
>     ACPI-1121: *** Error: , AE_NOT_FOUND
> 
> 	dmesg from 2.5.69, lspci and .config available at:
> 
> 	http://acm.cs.nyu.edu/~tugrul/acpi/
> 
> 	Otherwise, 2.5.69 is a fine release on my Compaq W8000.
> 
> 	Tugrul Galatali


