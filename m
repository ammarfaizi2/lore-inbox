Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753811AbWKGBDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753811AbWKGBDE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 20:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753854AbWKGBDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 20:03:04 -0500
Received: from cantor.suse.de ([195.135.220.2]:33664 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1753811AbWKGBDB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 20:03:01 -0500
From: Andreas Schwab <schwab@suse.de>
To: Lasse Karkkainen <tronic@trn.iki.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Mapping between ata9 and /dev/sd[a-z]
References: <454FD142.5060103@trn.iki.fi>
X-Yow: ..  are the STEWED PRUNES still in the HAIR DRYER?
Date: Tue, 07 Nov 2006 02:02:59 +0100
In-Reply-To: <454FD142.5060103@trn.iki.fi> (Lasse Karkkainen's message of
	"Tue, 07 Nov 2006 02:20:18 +0200")
Message-ID: <jefycwukzg.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lasse Karkkainen <tronic@trn.iki.fi> writes:

> I am getting errors from ata9 (and ata10), but how can I find which HDD
> it is? The kernel log never mentions ataN and its associated device name
> together.

Try looking in /sys for clues.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
