Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVE2NQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVE2NQY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 09:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVE2NQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 09:16:24 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:37337 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261302AbVE2NQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 09:16:16 -0400
Date: Sun, 29 May 2005 15:16:11 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SATA NCQ support
Message-ID: <20050529131611.GB13418@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050527070353.GL1435@suse.de> <20050527131842.GC19161@merlin.emma.line.org> <20050527135258.GW1435@suse.de> <429732CE.5010708@gmx.de> <20050527145821.GX1435@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050527145821.GX1435@suse.de>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 May 2005, Jens Axboe wrote:

> > suck and should not be cared about, and if I were to go into SATA, I
> > should just get a new controller and forget about my onboard VIA crap.
> > (I read newer VIA are supposed to support AHCI which is good.)
> 
> SATA is still pretty fast without NCQ, it just makes some operations a

Do I take this as SATA is faster than legacy ATA? In what respect?
UDMA/33 and SATA I shouldn't be much different if I use the same drive,
or is there something?

> lot faster. But of course if you want the best, you would opt for some
> setup that allows NCQ.

If I am to switch away from SCSI, NCQ is certainly a requirement,
otherwise I can continue to use my oldish Tekram DC-390U2W. :-)

> People have lived happily without NCQ support in SATA for years, I'm
> sure you could too :-)

Unless I needed to get some adaptors or power supply with SATA
connectors %-)

-- 
Matthias Andree
