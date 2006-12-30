Return-Path: <linux-kernel-owner+w=401wt.eu-S1754375AbWL3MlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754375AbWL3MlX (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 07:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754377AbWL3MlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 07:41:23 -0500
Received: from ns2.suse.de ([195.135.220.15]:34979 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754373AbWL3MlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 07:41:22 -0500
From: Andreas Schwab <schwab@suse.de>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org,
       linux1394-devel@lists.sourceforge.net,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.20-rc2: kernel BUG at include/asm/dma-mapping.h:110!
References: <je7iwa1l8a.fsf@sykes.suse.de>
	<1167429171.23340.125.camel@localhost.localdomain>
	<tkrat.f159c58fec599d72@s5r6.in-berlin.de>
X-Yow: Do I have a lifestyle yet?
Date: Sat, 30 Dec 2006 13:41:16 +0100
In-Reply-To: <tkrat.f159c58fec599d72@s5r6.in-berlin.de> (Stefan Richter's
	message of "Fri, 29 Dec 2006 23:47:04 +0100 (CET)")
Message-ID: <jehcvdo8sz.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Richter <stefanr@s5r6.in-berlin.de> writes:

> The parent device of my bogus fw-host device should do the trick. Alas I
> can't test on ppc64 or with anything else than ohci1394 driven
> controllers...

Successfully tested on ppc64.

Thanks, Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
