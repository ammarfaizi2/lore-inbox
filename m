Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262346AbVBXNiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262346AbVBXNiY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 08:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbVBXNiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 08:38:23 -0500
Received: from zeus.kernel.org ([204.152.189.113]:16828 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262346AbVBXNh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 08:37:59 -0500
Date: Thu, 24 Feb 2005 13:37:16 +0100
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       Pavel Machek <pavel@suse.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
Subject: Re: [ACPI] Call for help: list of machines with working S3
Message-ID: <20050224123716.GD28961@gamma.logic.tuwien.ac.at>
References: <20050214211105.GA12808@elf.ucw.cz> <20050215125555.GD16394@gamma.logic.tuwien.ac.at> <42121EC5.8000004@gmx.net> <20050215170837.GA6336@gamma.logic.tuwien.ac.at> <20050222220828.GB538@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050222220828.GB538@hell.org.pl>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Die, 22 Feb 2005, Karol Kozimor wrote:
> Thus wrote Norbert Preining:
> > - DRI must be disabled I guess?! Even with newer X server (x.org)?
> 
> You still didn't state which X server are you using. In short, XFree86 4.4,

I have stated it several times, but here a sum up:

- XFree86 4.3 (debian/sid) 
	no work
- X.Org 6.8.1.99 (debian -dri-trunk stuff plus kernel modules9
	no work
	with 2.6.11-rc4 and 2.6.11-rc3-mm2
	this server crashes when switching to the console or shutting
	down (crashing is sometimes, not always), very nice screen which
	slowly turns white

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>                 Università di Siena
sip:preining@at43.tuwien.ac.at                             +43 (0) 59966-690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
QUEDGELEY (n.)
A rabidly left-wing politician who can afford to be that way because
he married a millionairess.
			--- Douglas Adams, The Meaning of Liff
