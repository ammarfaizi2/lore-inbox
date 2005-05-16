Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261717AbVEPQBC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbVEPQBC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 12:01:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVEPQBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 12:01:02 -0400
Received: from pop.gmx.de ([213.165.64.20]:58503 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261717AbVEPQA5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 12:00:57 -0400
X-Authenticated: #428038
Date: Mon, 16 May 2005 18:00:50 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: "Richard B. Johnson" <linux-os@analogic.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Matthias Andree <matthias.andree@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: [OT] drive behavior on power-off (was: Disk write cache)
Message-ID: <20050516160050.GE949@merlin.emma.line.org>
Mail-Followup-To: "Richard B. Johnson" <linux-os@analogic.com>,
	Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
References: <1115963481.1723.3.camel@alderaan.trey.hu> <20050515145241.GA5627@irc.pl> <Pine.LNX.4.58.0505151657230.19181@artax.karlin.mff.cuni.cz> <200505151121.36243.gene.heskett@verizon.net> <Pine.LNX.4.58.0505151809240.26531@artax.karlin.mff.cuni.cz> <20050516111859.GB13387@merlin.emma.line.org> <4288AF3A.2000008@pobox.com> <Pine.LNX.4.61.0505161057570.18962@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0505161057570.18962@chaos.analogic.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.9i
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2005, Richard B. Johnson wrote:

> Then I suggest you never use such a drive. Anything that does this,
> will end up replacing a good track with garbage. Unless a disk drive
> has a built-in power source such as super-capacitors or batteries, what
> happens during a power-failure is that all electronics stops and
> the discs start coasting. Eventually the heads will crash onto
> the platter. Older discs had a magnetically released latch which would
> send the heads to an inside landing zone. Nobody bothers anymore.

IBM/Hitachi hard disk drives still use a "load/unload ramp" that
entirely moves the heads off the platters - I've known this since the
DJNA, and it is still advertised in Deskstar 7K500 and Ultrastar 15K147
to name just two examples.

-- 
Matthias Andree
