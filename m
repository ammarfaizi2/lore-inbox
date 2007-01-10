Return-Path: <linux-kernel-owner+w=401wt.eu-S965140AbXAJWEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965140AbXAJWEa (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 17:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965142AbXAJWE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 17:04:29 -0500
Received: from mx1.suse.de ([195.135.220.2]:57208 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965140AbXAJWE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 17:04:29 -0500
From: Andreas Schwab <schwab@suse.de>
To: =?iso-8859-1?Q?J=2EA=2E_Magall=F3n?= <jamagallon@ono.com>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       "Robert P. J. Day" <rpjday@mindspring.com>,
       "Stefan Richter" <stefanr@s5r6.in-berlin.de>,
       "Linux kernel mailing list" <linux-kernel@vger.kernel.org>
Subject: Re: macros:  "do-while" versus "({ })" and a compile-time error
References: <Pine.LNX.4.64.0701081347410.32420@localhost.localdomain>
	<45A3D1DF.4020205@s5r6.in-berlin.de>
	<Pine.LNX.4.61.0701091415200.12545@chaos.analogic.com>
	<Pine.LNX.4.64.0701100116420.10133@localhost.localdomain>
	<Pine.LNX.4.61.0701100715330.16104@chaos.analogic.com>
	<20070110224922.2de6a641@werewolf-wl>
X-Yow: I have a very good DENTAL PLAN.  Thank you.
Date: Wed, 10 Jan 2007 23:04:27 +0100
In-Reply-To: <20070110224922.2de6a641@werewolf-wl> (J. A. =?iso-8859-1?Q?M?=
 =?iso-8859-1?Q?agall=F3n's?= message
	of "Wed, 10 Jan 2007 22:49:22 +0100")
Message-ID: <jeodp6r11w.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallón" <jamagallon@ono.com> writes:

> {} is a compund command and ({ }) is a compund expression
> (or block expression, do not know which is the good name in engelish).

gcc calls it a statement expression.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
