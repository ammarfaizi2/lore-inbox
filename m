Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262611AbVAKWPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262611AbVAKWPo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 17:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbVAKWPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 17:15:40 -0500
Received: from orb.pobox.com ([207.8.226.5]:14236 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262611AbVAKWOS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 17:14:18 -0500
Date: Tue, 11 Jan 2005 14:14:12 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-mm2: swsusp problem with resuming on batteries (AMD64)
Message-ID: <20050111221412.GC4378@ip68-4-98-123.oc.oc.cox.net>
References: <200501112220.53011.rjw@sisk.pl> <20050111212647.GB1802@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050111212647.GB1802@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The box is an Athlon 64 laptop on NForce 3.
> 
> Can you try without cpufreq support? If we attempt to do 2GHz on AC
> power, machine may die ugly death.

Athlon 64 probably means it's running an x86_64 kernel. Wasn't there
another thread on lkml about -mm2 swsusp and x86_64? I wonder if it's
the same problem (or a related one).

-Barry K. Nathan <barryn@pobox.com>

