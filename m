Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935864AbWLCLej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935864AbWLCLej (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 06:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935867AbWLCLej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 06:34:39 -0500
Received: from mail.suse.de ([195.135.220.2]:17077 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S935864AbWLCLei (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 06:34:38 -0500
From: Andreas Schwab <schwab@suse.de>
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: why can't I remove a kernel module (or: what uses a given module)?
References: <4572B30F.9020605@wpkg.org>
X-Yow: I wonder if I should put myself in ESCROW!!
Date: Sun, 03 Dec 2006 12:34:36 +0100
In-Reply-To: <4572B30F.9020605@wpkg.org> (Tomasz Chmielewski's message of
	"Sun, 03 Dec 2006 12:20:47 +0100")
Message-ID: <jewt592oxf.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Chmielewski <mangoo@wpkg.org> writes:

> What was using the module in the first scenario (I couldn't remove the
> module)?

Check lsmod for modules depending on this one.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
