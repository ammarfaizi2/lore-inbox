Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbUBWMkz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 07:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbUBWMkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 07:40:55 -0500
Received: from ns.suse.de ([195.135.220.2]:13022 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261796AbUBWMkx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 07:40:53 -0500
To: Jeff Sipek <jeffpc@optonline.net>
Cc: Pavel Machek <pavel@ucw.cz>,
       =?iso-8859-1?q?Markus_H=E4stbacka?= <midian@ihme.org>,
       Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [NET] 64 bit byte counter for 2.6.3
References: <1077123078.9223.7.camel@midux> <20040222173622.GB1371@elf.ucw.cz>
	<200402230634.33531.jeffpc@optonline.net>
From: Andreas Schwab <schwab@suse.de>
X-Yow: YOW!!  Now I'm playing with my HOLOGRAPHIC ATOMIC SIMULATION LASER
 pinball machine!!  WORLD PEACE is in the BALANCE!!
Date: Mon, 23 Feb 2004 13:38:52 +0100
In-Reply-To: <200402230634.33531.jeffpc@optonline.net> (Jeff Sipek's message
 of "Mon, 23 Feb 2004 06:34:23 -0500")
Message-ID: <je4qti2co3.fsf@sykes.suse.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Sipek <jeffpc@optonline.net> writes:

> Hmm...I've been told that u_int64_t is the C99 (IIRC) standard

In C99 it's spelt uint64_t.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
