Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbVI1PX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbVI1PX2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 11:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbVI1PX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 11:23:28 -0400
Received: from S01060013109fe3d4.vc.shawcable.net ([24.85.133.133]:6601 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S1751276AbVI1PX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 11:23:27 -0400
Date: Wed, 28 Sep 2005 08:29:55 -0700 (PDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Clemens Koller <clemens.koller@anagramm.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13.2 crash on shutdown on SMP machine
In-Reply-To: <433A747E.3070705@anagramm.de>
Message-ID: <Pine.LNX.4.61.0509280828270.1684@montezuma.fsmlabs.com>
References: <433A747E.3070705@anagramm.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2005, Clemens Koller wrote:

> I can try the latest git or 2.6.14-rc2 tonight and get you
> some more info (.config) when I am back home...
> BTW what is IPI? Any ideas? What do you need to track down

Forgot to answer your other question, IPI is Inter Processor Interrupt, 
the cpu's method of triggering an interrupt on remote processors.
