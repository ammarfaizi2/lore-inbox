Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265533AbUBAWqd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 17:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265536AbUBAWqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 17:46:32 -0500
Received: from gprs158-128.eurotel.cz ([160.218.158.128]:34177 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265533AbUBAWqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 17:46:31 -0500
Date: Sun, 1 Feb 2004 23:46:22 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Huw Rogers <count0@localnet.com>
Cc: linux-kernel@vger.kernel.org, ncunningham@users.sourceforge.net,
       linux-laptop@mobilix.org, acpi-devel@lists.sourceforge.net
Subject: Re: APM good, ACPI bad (2.6.2-rc1 / p4 HT / Uniwill N258SA0)
Message-ID: <20040201224621.GA785@elf.ucw.cz>
References: <1075231649.18386.34.camel@laptop-linux> <37778.199.172.169.20.1075236597.squirrel@webmail.localnet.com> <20040201151411.3A7B.COUNT0@localnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040201151411.3A7B.COUNT0@localnet.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Got Uniwill N258SA0 laptop suspend/resume working (2.6.2-rc1-mm3) with
> APM. Patch enclosed. CPU is desktop P4 with hyperthreading.

The patch is rather big. Can you get someone to test it with ACPI, and
if it helps (or at least does not break things), submit to Andrew?

[Do *not* enable suspend on SMP for mainline, unless you are willing
to audit that code...]

								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
