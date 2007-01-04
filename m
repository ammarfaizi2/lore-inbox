Return-Path: <linux-kernel-owner+w=401wt.eu-S964798AbXADSIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbXADSIy (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 13:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbXADSIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 13:08:54 -0500
Received: from mail.suse.de ([195.135.220.2]:37313 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964798AbXADSIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 13:08:53 -0500
From: Andreas Schwab <schwab@suse.de>
To: "Albert Cahalan" <acahalan@gmail.com>
Cc: "Segher Boessenkool" <segher@kernel.crashing.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, s0348365@sms.ed.ac.uk, bunk@stusta.de,
       mikpe@it.uu.se, torvalds@osdl.org
Subject: Re: kernel + gcc 4.1 = several problems
References: <787b0d920701032311l2c37c248s3a97daf111fe88f3@mail.gmail.com>
	<27e6f108b713bb175dd2e77156ef61d0@kernel.crashing.org>
	<787b0d920701040904i553e521fsb290acf5059f0b62@mail.gmail.com>
X-Yow: I was born in a Hostess Cupcake factory before the sexual revolution!
Date: Thu, 04 Jan 2007 19:08:07 +0100
In-Reply-To: <787b0d920701040904i553e521fsb290acf5059f0b62@mail.gmail.com>
	(Albert Cahalan's message of "Thu, 4 Jan 2007 12:04:18 -0500")
Message-ID: <jed55uacmw.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert Cahalan" <acahalan@gmail.com> writes:

> FYI, the kernel also assumes that a "char" is 8 bits.
> Maybe you should run away screaming.

You are confusing "undefined" with "implementation defined".  Those are
two quite different concepts.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
