Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262658AbTHZOHU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 10:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263935AbTHZODq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 10:03:46 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:34565 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S263861AbTHZODQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 10:03:16 -0400
Subject: Re: [ACPI] 2.4.22, My bios is to old?
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Ian Kumlien <pomac@vapor.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1061901388.7167.19.camel@big.pomac.com>
References: <1061901388.7167.19.camel@big.pomac.com>
Content-Type: text/plain
Message-Id: <1061906591.678.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 26 Aug 2003 16:03:12 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-26 at 14:36, Ian Kumlien wrote:

> I just updated $other machine to 2.4.22, and now i have several ACPI
> tools screaming at me because /proc/acpi dosn't exist.
> (it was running 2.4.21-pre1, it has aslo been running with several acpi
> patches)

Boot the kernel using "acpi=force"...

