Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267096AbSKMB43>; Tue, 12 Nov 2002 20:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267099AbSKMB43>; Tue, 12 Nov 2002 20:56:29 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:53771 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267096AbSKMB42>; Tue, 12 Nov 2002 20:56:28 -0500
Date: Wed, 13 Nov 2002 02:03:18 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Matthias Urlichs <smurf@noris.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.4: scsi and BLK_STATS
Message-ID: <20021113020318.A3580@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matthias Urlichs <smurf@noris.de>, linux-kernel@vger.kernel.org
References: <20021112172821.GA14195@play.smurf.noris.de> <20021113001530.A323@infradead.org> <20021113023059.K18881@noris.de> <20021113013717.A3008@infradead.org> <20021113024118.M18881@noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021113024118.M18881@noris.de>; from smurf@noris.de on Wed, Nov 13, 2002 at 02:41:18AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2002 at 02:41:18AM +0100, Matthias Urlichs wrote:
> > It already gets genhd.h through blk.h -> blkdev.h.. :)
> 
> ... then why did I get that undefined symbol in scsi_mod.o, I wonder ??

I can't reproduce it here, so I wonder, too.  Can you send me you
.config offlist?

