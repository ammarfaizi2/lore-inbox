Return-Path: <linux-kernel-owner+w=401wt.eu-S1751056AbWLQUDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbWLQUDS (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 15:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWLQUDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 15:03:18 -0500
Received: from khc.piap.pl ([195.187.100.11]:36589 "EHLO khc.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751070AbWLQUDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 15:03:17 -0500
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove the broken SCSI_SEAGATE driver
References: <20061212162238.GR28443@stusta.de>
	<1165966274.5903.56.camel@mulgrave.il.steeleye.com>
	<20061213000902.GD28443@stusta.de>
	<m3wt4tp9ka.fsf@defiant.localdomain>
	<1166198454.2846.10.camel@mulgrave.il.steeleye.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sun, 17 Dec 2006 21:03:15 +0100
In-Reply-To: <1166198454.2846.10.camel@mulgrave.il.steeleye.com> (James Bottomley's message of "Fri, 15 Dec 2006 10:00:54 -0600")
Message-ID: <m3ac1mb88s.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com> writes:

> I really don't see a need to declare drivers obsolete unless they bitrot
> to the point they're demonstrably useless and no-one wants to step up to
> fix them, which is what the BROKEN flag is for.

How do you know if the driver is broken? Especially if it still
compiles?

Some of these things are 20 years old.
-- 
Krzysztof Halasa
