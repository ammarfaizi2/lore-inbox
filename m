Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbVJDRQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbVJDRQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 13:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbVJDRQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 13:16:29 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:56580 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S964859AbVJDRQ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 13:16:28 -0400
Date: Tue, 4 Oct 2005 18:16:36 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       fastboot@osdl.org
Subject: Re: [PATCH] i386: move apic init in init_IRQs
In-Reply-To: <m1psql707i.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.61L.0510041811590.10696@blysk.ds.pg.gda.pl>
References: <m1fyrh8gro.fsf@ebiederm.dsl.xmission.com>
 <Pine.LNX.4.61L.0510041628160.10696@blysk.ds.pg.gda.pl>
 <m1psql707i.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Oct 2005, Eric W. Biederman wrote:

> lapic_disable() already does this.  I am just testing the results.

 I see -- this just proves how big a mess the current code is. ;-)

> So what should the capitalization be? "APIC disabled\n" ?

 Obviously.  Thanks for your tidy-up!

  Maciej
