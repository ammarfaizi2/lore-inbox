Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261720AbVDENYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbVDENYW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 09:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbVDENYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 09:24:22 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:30418 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S261720AbVDENYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 09:24:18 -0400
Date: Tue, 5 Apr 2005 15:24:17 +0200
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Re: 2.6.12-rc1-mm4 and suspend2ram (and synaptics)
Message-ID: <20050405132417.GA23894@gamma.logic.tuwien.ac.at>
References: <20050331220822.GA22418@gamma.logic.tuwien.ac.at> <20050401113335.GA13160@elf.ucw.cz> <20050403224557.GB1015@gamma.logic.tuwien.ac.at> <20050403225929.GE13466@elf.ucw.cz> <20050404081600.GA2424@gamma.logic.tuwien.ac.at> <20050405100644.GA1345@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050405100644.GA1345@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Die, 05 Apr 2005, Pavel Machek wrote:
> > It's b44. It *was* working with b44 insmod-ed and up and running, but
> > now as soon as b44-eth0 is ifup-ed while suspending, the resume freezes.
> > If I do a ifdown eth0 before suspending, it works.
> 
> Does this one help?


With 2.6.12-rc1-mm4 it did help. For 2.6.12-rc2-mm1 see previous email.
Thanks.

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining AT logic DOT at>             Università di Siena
sip:preining@at43.tuwien.ac.at                             +43 (0) 59966-690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
KITMURVY (n.)
Man who owns all the latest sporting gadgetry and clothing (gold
trolley, tee cosies, ventilated shoes, Gary Player- autographed
tracksuit top, American navy cap, mirror sunglasses) but is still only
on his second gold lesson.
			--- Douglas Adams, The Meaning of Liff
