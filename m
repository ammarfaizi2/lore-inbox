Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbVAAXO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVAAXO7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 18:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVAAXO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 18:14:59 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:23471 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S261196AbVAAXO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 18:14:58 -0500
To: John M Flinchbaugh <john@hjsoft.com>
Cc: linux-kernel@vger.kernel.org, <pavel@ucw.cz>
Subject: Re: 2.6.10: e100 network broken after swsusp/resume
In-Reply-To: <20050101221722.GA28045@butterfly.hjsoft.com>
References: <20041228144741.GA2969@butterfly.hjsoft.com> <20050101172344.GA1355@elf.ucw.cz> <20050101172344.GA1355@elf.ucw.cz> <20050101221722.GA28045@butterfly.hjsoft.com>
Date: Sat, 1 Jan 2005 23:14:57 +0000
Message-Id: <E1CksSX-0003Ki-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John M Flinchbaugh <john@hjsoft.com> wrote:

> it had been fine in 2.6.9.  i think i had switched to using apic back
> with 2.6.9 (to facilitate nmi_watchdog, maybe).
> 
> i'll try these options.  ultimately, though, i'm going to need acpi. :)

Does pci=routeirq make any difference?

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
