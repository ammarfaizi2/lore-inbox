Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423843AbWJaUMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423843AbWJaUMp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 15:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423838AbWJaUMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 15:12:44 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:8359 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1423555AbWJaUMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 15:12:41 -0500
Subject: Re: 2.6.19-rc4: known unfixed regressions
From: Arjan van de Ven <arjan@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Chua <jeff.chua.linux@gmail.com>, gregkh@suse.de,
       linux-pci@atrey.karlin.mff.cuni.cz,
       Prakash Punnoor <prakash@punnoor.de>, phil.el@wanadoo.fr,
       oprofile-list@lists.sourceforge.net, ak@suse.de, discuss@x86-64.org,
       Martin Lorenz <martin@lorenz.eu.org>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Hugh Dickins <hugh@veritas.com>, len.brown@intel.com,
       linux-acpi@vger.kernel.org, pavel@suse.cz, linux-pm@osdl.org,
       Thierry Vignaud <tvignaud@mandriva.com>, jgarzik@pobox.com,
       linux-ide@vger.kernel.org, Alex Romosan <romosan@sycorax.lbl.gov>,
       Jens Axboe <jens.axboe@oracle.com>, Christian <christiand59@web.de>,
       davej@codemonkey.org.uk, cpufreq@lists.linux.org.uk,
       Komuro <komurojun-mbn@nifty.com>, Thomas Gleixner <tglx@linutronix.de>,
       Randy Dunlap <randy.dunlap@oracle.com>, Arnd Bergmann <arnd@arndb.de>,
       David Brownell <david-b@pacbell.net>,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20061031195654.GV27968@stusta.de>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>
	 <20061031195654.GV27968@stusta.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 31 Oct 2006 21:12:17 +0100
Message-Id: <1162325537.3044.49.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-31 at 20:56 +0100, Adrian Bunk wrote:
> This email lists some known regressions in 2.6.19-rc4 compared to 2.6.18
> that are not yet fixed in Linus' tree.
> 
> If you find your name in the Cc header, you are either submitter of one
> of the bugs, maintainer of an affectected subsystem or driver, a patch
> of you caused a breakage or I'm considering you in any other way possibly
> involved with one or more of these issues.
> 
> Due to the huge amount of recipients, please trim the Cc when answering.
> 
> 
> Subject    : PCI: MMCONFIG breakage
> References : http://lkml.org/lkml/2006/10/27/251
> Submitter  : Jeff Chua <jeff.chua.linux@gmail.com>
> Status     : unknown, both BIOS and Direct work
> 


hmm I see nothing MMCONFIG related here much....

