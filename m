Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265479AbTLHQbe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 11:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265478AbTLHQ2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 11:28:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:50621 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265480AbTLHQ1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 11:27:08 -0500
Date: Mon, 8 Dec 2003 08:19:17 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: gene.heskett@verizon.net
Cc: helgehaf@aitel.hist.no, zdzichu@irc.pl, linux-kernel@vger.kernel.org
Subject: Re: Large-FAT32-Filesystem Bug
Message-Id: <20031208081917.0a10b4db.rddunlap@osdl.org>
In-Reply-To: <200312080910.48676.gene.heskett@verizon.net>
References: <3FD0555F.5060608@gmx.de>
	<20031207122034.GA17042@irc.pl>
	<3FD44A6F.2060707@aitel.hist.no>
	<200312080910.48676.gene.heskett@verizon.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Dec 2003 09:10:48 -0500 Gene Heskett <gene.heskett@verizon.net> wrote:

| On Monday 08 December 2003 04:54, Helge Hafting wrote:
| [...]
| 
| >Digital cameras and such simply don't need long names.
| >
| >Helge Hafting
| >
| Humm, I'd argue that point, mine (Olympus C-3020) does a datestamp 
| right in the filename, making it very easy to pick out the pix you 
| shot while visiting someplace special.  Thats at least as handy as 
| sliced bread or bottled beer IMO.

but if it were important not to use long filenames, they could get
around this by using directories that contain the date info (only),
and files for that date inside each dir.  E.g.,

20031201 <dir>
  dscn0101.jpg
  dscn0102.jpg
20031208 <dir>
  dscn0103.jpg
  dscn0104.jpg

--
~Randy
MOTD:  Always include version info.
