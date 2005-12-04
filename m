Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbVLDPgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbVLDPgz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 10:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbVLDPgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 10:36:55 -0500
Received: from cantor2.suse.de ([195.135.220.15]:33729 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932255AbVLDPgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 10:36:53 -0500
From: Andreas Schwab <schwab@suse.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <20051203162755.GA31405@merlin.emma.line.org>
	<1133630556.22170.26.camel@laptopd505.fenrus.org>
	<20051203230520.GJ25722@merlin.emma.line.org>
	<43923DD9.8020301@wolfmountaingroup.com>
	<20051204121209.GC15577@merlin.emma.line.org>
	<1133699555.5188.29.camel@laptopd505.fenrus.org>
	<20051204132813.GA4769@merlin.emma.line.org>
	<1133703338.5188.38.camel@laptopd505.fenrus.org>
	<20051204142551.GB4769@merlin.emma.line.org>
	<1133707855.5188.41.camel@laptopd505.fenrus.org>
	<20051204150804.GA17846@merlin.emma.line.org>
X-Yow: Yow!  I'm out of work...I could go into shock absorbers...or SCUBA
 GEAR!!
Date: Sun, 04 Dec 2005 16:36:51 +0100
In-Reply-To: <20051204150804.GA17846@merlin.emma.line.org> (Matthias Andree's
	message of "Sun, 4 Dec 2005 16:08:04 +0100")
Message-ID: <jebqzw50x8.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@gmx.de> writes:

> Yes. "extern type foo; static type foo;" is way stupid, but 10% of the
> blame can be shifted on the GCC guys for being much too tolerant.

You should rather blame the C standard.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
