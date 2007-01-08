Return-Path: <linux-kernel-owner+w=401wt.eu-S965270AbXAHAft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965270AbXAHAft (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 19:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965274AbXAHAft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 19:35:49 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:40810 "EHLO
	mail.holtmann.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965270AbXAHAfs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 19:35:48 -0500
Subject: Re: 2.6.20-rc4: known regressions with patches available
From: Marcel Holtmann <marcel@holtmann.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, bluez-devel@lists.sourceforge.net,
       netdev@vger.kernel.org, Michael Reske <micha@gmx.com>,
       Ayaz Abdulla <aabdulla@nvidia.com>, jgarzik@pobox.com,
       Brice Goglin <brice@myri.com>, Robert Hancock <hancockr@shaw.ca>,
       gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <20070108002555.GP20714@stusta.de>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
	 <20070108002555.GP20714@stusta.de>
Content-Type: text/plain
Date: Mon, 08 Jan 2007 01:33:38 +0100
Message-Id: <1168216418.12025.11.camel@violet>
Mime-Version: 1.0
X-Mailer: Evolution 2.9.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

> This email lists some known regressions in 2.6.20-rc4 compared to 2.6.19
> with patches available.
> 
> If you find your name in the Cc header, you are either submitter of one
> of the bugs, maintainer of an affectected subsystem or driver, a patch
> of you caused a breakage or I'm considering you in any other way possibly
> involved with one or more of these issues.
> 
> Due to the huge amount of recipients, please trim the Cc when answering.
> 
> 
> Subject    : bluetooth oopses because of multiple kobject_add()
> References : http://lkml.org/lkml/2007/1/2/101
> Submitter  : Pavel Machek <pavel@ucw.cz>
> Handled-By : Marcel Holtmann <marcel@holtmann.org>
> Patch      : http://lkml.org/lkml/2007/1/2/147
> Status     : patch available

the patch has been forwarded to Dave Miller.

Regards

Marcel


