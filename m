Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270737AbTGNSXu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 14:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270741AbTGNSXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 14:23:49 -0400
Received: from beta.galatali.com ([216.40.241.205]:30120 "EHLO
	beta.galatali.com") by vger.kernel.org with ESMTP id S270737AbTGNSXl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 14:23:41 -0400
Subject: Re: Linux 2.6-pre1 Does not boot on ASUS L3800C: lock up in acpi
	while "Executing all Devices _STA and_INIT methods"
From: Tugrul Galatali <tugrul@galatali.com>
To: linux-kernel@vger.kernel.org, andrew.grover@intel.com,
       acpi-devel@lists.sourceforge.net
In-Reply-To: <3F12AF06.6080004@free.fr>
References: <3F12AF06.6080004@free.fr>
Content-Type: text/plain
Message-Id: <1058207908.704.5.camel@duality.galatali.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 14 Jul 2003 14:38:28 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-07-14 at 09:24, Eric Valette wrote:
> I happily run 2.4.21-pre5 with ACPI enabled and everything works just 
> fine. I tried today 2.6-pre1 with exactly the same hardware 
> configuration as the 2.4 one and the laptop does not boot. It hangs 
> while dispaying : "Executing all Devices _STA and_INIT methods" 
> allthough it has already printed several '.'

	I get that error plus the message I've been getting from >2.5.69
kernels when booting with ACPI on my Compaq W8000. dmesg/lspci/configs
at 

	http://acm.cs.nyu.edu/~tugrul/acpi/

	The 2.6.0-test1 error is pretty big for hand transcription, but I'll
try setting up serial console if requested.

	Tugrul Galatali


