Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132638AbRBEDeq>; Sun, 4 Feb 2001 22:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132641AbRBEDeg>; Sun, 4 Feb 2001 22:34:36 -0500
Received: from 200-221-84-35.dsl-sp.uol.com.br ([200.221.84.35]:11013 "HELO
	dumont.rtb.ath.cx") by vger.kernel.org with SMTP id <S132638AbRBEDe2>;
	Sun, 4 Feb 2001 22:34:28 -0500
Date: Mon, 5 Feb 2001 01:34:24 -0200
From: Rogerio Brito <rbrito@iname.com>
To: linux-kernel@vger.kernel.org
Subject: Slowing down CDROM drives (was: Re: ATAPI CDRW which doesn't work)
Message-ID: <20010205013424.A15384@iname.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010203230544.A549@MourOnLine.dnsalias.org> <20010205020952.B1276@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010205020952.B1276@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 05 2001, Jens Axboe wrote:
> On Sat, Feb 03 2001, patrick.mourlhon@wanadoo.fr wrote:
> > Feb  3 22:08:25 Line kernel: hdb: irq timeout: status=0xd0 { Busy }
> > Feb  3 22:08:25 Line kernel: hdb: DMA disabled
> > Feb  3 22:08:55 Line kernel: hdb: ATAPI reset timed-out, status=0x90
> > Feb  3 22:08:55 Line kernel: hda: DMA disabled
> 
> Try disabling DMA on the drive before accessing it. 

	Well, this has nothing to do with the above, but is there any
	utility or /proc entry that lets me say to my CD drive that it
	should not work at full speed?

	Basically, some drives make way too much noise when they're
	operating at full speed. When I'd like to listen to some MP3s
	from a burned CD-R, what I'm currently doing is copying the
	files that I want to /tmp and listening from there, but this
	is obviously a dirty solution. :-(


	Thanks in advance for any hints, Roger...

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogerio Brito - rbrito@iname.com - http://www.ime.usp.br/~rbrito/
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
