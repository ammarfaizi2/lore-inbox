Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262600AbVA0Mw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262600AbVA0Mw5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 07:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbVA0Mw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 07:52:56 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:30873 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S262600AbVA0Mwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 07:52:49 -0500
Date: Thu, 27 Jan 2005 13:52:31 +0100
To: Andrew Morton <akpm@osdl.org>, Joe Perches <joe@perches.com>,
       Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1 strange messages
Message-ID: <20050127125230.GA2477@gamma.logic.tuwien.ac.at>
References: <20050125102834.7e549322.akpm@osdl.org> <1106784100.11830.430.camel@d845pe> <20050125121704.GA22610@gamma.logic.tuwien.ac.at> <20050125102834.7e549322.akpm@osdl.org> <1106679006.11688.26.camel@localhost.localdomain> <20050125121704.GA22610@gamma.logic.tuwien.ac.at> <20050125102834.7e549322.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1106784100.11830.430.camel@d845pe> <1106679006.11688.26.camel@localhost.localdomain> <20050125102834.7e549322.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

I used the patch by Joe and got:

Built 1 zonelists
iounmap: bad address c00fffd9
 [<c0404430>] trap_init+0x30/0x190
 [<c03fe697>] start_kernel+0x47/0x1c0
Local APIC disabled by BIOS -- you can enable it with "lapic"


On Mit, 26 Jan 2005, Len Brown wrote:
> Better yet, can you please add this?
> 
> http://lkml.org/lkml/2005/1/3/136

Hmm, it seems that this is included in 2.6.11-rc2-mm1, at least AFAIS.

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
sip:preining@at43.tuwien.ac.at                             +43 (0) 59966-690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
VANCOUVER (n.)
The technical name for one of those huge trucks with whirling brushes
on the bottom used to clean streets.
			--- Douglas Adams, The Meaning of Liff
