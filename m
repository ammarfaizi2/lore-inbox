Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262253AbVBQLHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbVBQLHK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 06:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbVBQLHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 06:07:10 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:63393 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S262253AbVBQLHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 06:07:04 -0500
Date: Thu, 17 Feb 2005 12:06:10 +0100
To: Stefan =?iso-8859-15?Q?D=F6singer?= <stefandoesinger@gmx.at>
Cc: acpi-devel@lists.sourceforge.net,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       Pavel Machek <pavel@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
Subject: Re: [ACPI] Call for help: list of machines with working S3
Message-ID: <20050217110610.GH29993@gamma.logic.tuwien.ac.at>
References: <20050214211105.GA12808@elf.ucw.cz> <42121EC5.8000004@gmx.net> <20050215170837.GA6336@gamma.logic.tuwien.ac.at> <200502152038.00401.stefandoesinger@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200502152038.00401.stefandoesinger@gmx.at>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Die, 15 Feb 2005, Stefan Dösinger wrote:
> > After deactivating DRI in the X config file and saving the states with
> > your script (thanks) and turning off various stuff I get X running
> > again.
> >
> > Questions:
> > - DRI must be disabled I guess?! Even with newer X server (x.org)?
>
> Do you use the fglrx driver? This doesn't work with any type of suspend so 

No

> far. If you use the radeon driver try a driver update.

>From deb http://www.nixnuts.net/files/ ./ ??

Or direct from dri.freedesktop.org, and updating X to X.org on sid?

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>                 Università di Siena
sip:preining@at43.tuwien.ac.at                             +43 (0) 59966-690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
SWANIBOST (adj.)
Complete shagged out after a hard day having income tax explained to
you.
			--- Douglas Adams, The Meaning of Liff
