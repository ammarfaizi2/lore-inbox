Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbUJaTQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbUJaTQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 14:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbUJaTQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 14:16:57 -0500
Received: from cantor.suse.de ([195.135.220.2]:2224 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261334AbUJaTQz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 14:16:55 -0500
To: Pavel Machek <pavel@suse.cz>
Cc: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Configurable Magic Sysrq
References: <20041029093941.GA2237@atrey.karlin.mff.cuni.cz>
	<20041031185222.GB5578@elf.ucw.cz>
From: Andreas Schwab <schwab@suse.de>
X-Yow: YOW!!  Now I understand advanced MICROBIOLOGY
 and th' new TAX REFORM laws!!
Date: Sun, 31 Oct 2004 20:12:10 +0100
In-Reply-To: <20041031185222.GB5578@elf.ucw.cz> (Pavel Machek's message of
 "Sun, 31 Oct 2004 19:52:22 +0100")
Message-ID: <jelldmbt2t.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> writes:

> Actually, there's one more thing that wories me... Original choice of
> PC hotkey (alt-sysrq-key) works *very* badly on many laptop
> keyboards. Like sysrq is only recognized with fn, but key is not
> recognized when you hold fn => you have no chance to use magic sysrq.

Doesn't it work to release fn (without releasing sysrq) before typing key?

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
