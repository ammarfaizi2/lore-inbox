Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263490AbTKQNPX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 08:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263491AbTKQNPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 08:15:23 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:516 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S263490AbTKQNPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 08:15:22 -0500
Subject: Re: Terrible interactivity with 2.6.0-t9-mm3
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: "Ronny V. Vindenes" <s864@ii.uib.no>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1069071092.3238.5.camel@localhost.localdomain>
References: <1069071092.3238.5.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1069074910.13798.3.camel@glass.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Mon, 17 Nov 2003 14:15:10 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-11-17 at 13:11, Ronny V. Vindenes wrote:

> I've found that neither linus.patch nor
> context-switch-accounting-fix.patch is causing the problem, but rather
> acpi-pm-timer-fixes.patch & acpi-pm-timer.patch

I'm running -mm3 and haven't noticed any interactivity problems as far
as the ACPI PM timer support is *not enabled*. Enabling ACPI PM timer,
makes the system feel rather sluggish.

