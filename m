Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbVCUUAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbVCUUAi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 15:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbVCUUAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 15:00:38 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:62596 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S261833AbVCUUAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 15:00:32 -0500
Date: Mon, 21 Mar 2005 21:00:24 +0100
To: Dominik Brodowski <linux@dominikbrodowski.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] pcmcia: select crc32 in Kconfig for PCMCIA [Was: Re: pcmcia compile problems in 2.6.11-mm4 and above]
Message-ID: <20050321200024.GA24865@gamma.logic.tuwien.ac.at>
References: <20050321150143.GB14614@gamma.logic.tuwien.ac.at> <20050321191353.GA13659@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050321191353.GA13659@isilmar.linta.de>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mär 2005, Dominik Brodowski wrote:
> That's a missing dependency on CONFIG_CRC32. Could you check whether this
> patch helps, please?

Yes, thanks.

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>                 Università di Siena
sip:preining@at43.tuwien.ac.at                             +43 (0) 59966-690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
DAMNAGLAUR (n.)
A certain facial expression which actors are required to demonstrate
their mastery of before they are allowed to play MacBeth.
			--- Douglas Adams, The Meaning of Liff
