Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbVBQTL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVBQTL7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 14:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262342AbVBQTLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 14:11:44 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:56256 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S262353AbVBQTJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 14:09:28 -0500
Date: Thu, 17 Feb 2005 20:09:24 +0100
To: Pavel Machek <pavel@suse.cz>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
Subject: Re: [ACPI] Call for help: list of machines with working S3
Message-ID: <20050217190924.GD4925@gamma.logic.tuwien.ac.at>
References: <20050214211105.GA12808@elf.ucw.cz> <20050215125555.GD16394@gamma.logic.tuwien.ac.at> <42121EC5.8000004@gmx.net> <20050215170837.GA6336@gamma.logic.tuwien.ac.at> <20050215194710.GE7338@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050215194710.GE7338@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Die, 15 Feb 2005, Pavel Machek wrote:
> > - Sometimes I have to make a Sysrq-s (sync) to get some stuff running
> >   (eg logging in from the console hangs after input of passwd, calling
> >   sysrq-s makes it continue). I had a similar effect when logging in
> >   AFTER resuming (for the resume I had only gdm running but wasn't
> >   logged in) the GNOME starting screen stayed there indefinitely, no
> >   change. Even after restarting the X server and retrying.
> >   Logging in with twm session DID work without any problem.
> >   Do you have any idea what this could be?
> 
> Does it happen with swsusp? Is it in any way reproducible? Maybe
> commenting out refrigerator would help....


Hmm, don't have swsusp in my kernel (2.6.11-rc3-mm2).

reproducible: Not deterministically, i.e. it happened again, but then
again not always. Sorry.


Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>                 Università di Siena
sip:preining@at43.tuwien.ac.at                             +43 (0) 59966-690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
PLYMOUTH (vb.)
To relate an amusing story to someone without remembering that it was
they who told it to you in the first place.
			--- Douglas Adams, The Meaning of Liff
