Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265420AbUBFNRN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 08:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265442AbUBFNRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 08:17:13 -0500
Received: from ns.suse.de ([195.135.220.2]:53918 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265420AbUBFNRM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 08:17:12 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Dylan Griffiths <dylang+kernel@thock.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: HFSPLus driver for Linux 2.6.
References: <402304F0.1070008@thock.com>
	<20040205191527.4c7a488e.akpm@osdl.org> <40231076.7040307@thock.com>
	<20040205200217.360c51ab.akpm@osdl.org>
	<1076051611.885.25.camel@gaston>
From: Andreas Schwab <schwab@suse.de>
X-Yow: HUMAN REPLICAS are inserted into VATS of NUTRITIONAL YEAST...
Date: Fri, 06 Feb 2004 14:15:26 +0100
In-Reply-To: <1076051611.885.25.camel@gaston> (Benjamin Herrenschmidt's
 message of "Fri, 06 Feb 2004 18:13:32 +1100")
Message-ID: <jeptcsxsb5.fsf@sykes.suse.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> One thing we absolutely need too is a port of Apple's fsck for HFS+,
> currently, the driver will refuse to mount read/write a "dirty"
> HFS+ filesystem to avoid corruption, but that means we have to reboot
> MacOS to fsck it then... 

Not reboot, but boot. MOL is your friend. :-)

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
