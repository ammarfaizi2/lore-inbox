Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272923AbTHKSI0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 14:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272824AbTHKSF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 14:05:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:64220 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272818AbTHKSF1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 14:05:27 -0400
Date: Mon, 11 Aug 2003 11:02:33 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Samuel Flory <sflory@rackable.com>
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre10 ACPI kennel oops
Message-Id: <20030811110233.36bd1f1a.rddunlap@osdl.org>
In-Reply-To: <3F37D49B.6050409@rackable.com>
References: <BF1FE1855350A0479097B3A0D2A80EE009FC12@hdsmsx402.hd.intel.com>
	<3F37D49B.6050409@rackable.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Aug 2003 10:38:35 -0700 Samuel Flory <sflory@rackable.com> wrote:

| Brown, Len wrote:
| 
| >Was ACPI included in your 2.4.21 kernel?  If no, then 2.4.22-pre10 may
| >be the 1st time that Linux ACPI has examined the tables on this system.
| >
| >I'm not familiar with "woodruf" -- do it have a part number?
| >First thing to do is to locate the latest BIOS for the board, and see if
| >this is something that has already been fixed there.
| >
| >If the latest BIOS doesn't do it, then filing a bug under componenet
| >ACPI will be the best way to get it fixed w/o having it fall through the
| >
| 
|   Still fails.  A bug with quad, or the ACPI project?

ACPI bugs can (should) be filed at bugme.osdl.org (or
bugzilla.kernel.org) for both 2.4 and 2.5.

--
~Randy				For Linux-2.6, see:
http://www.kernel.org/pub/linux/kernel/people/davej/misc/post-halloween-2.5.txt
