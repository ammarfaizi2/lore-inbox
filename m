Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129367AbRBVKxT>; Thu, 22 Feb 2001 05:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129714AbRBVKxK>; Thu, 22 Feb 2001 05:53:10 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:274 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129539AbRBVKxC>; Thu, 22 Feb 2001 05:53:02 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14996.61315.647325.114938@wire.cadcamlab.org>
Date: Thu, 22 Feb 2001 04:52:51 -0600 (CST)
To: Christoph Hellwig <hch@caldera.de>
Cc: lvm-devel@sistina.com, linux-kernel@vger.kernel.org
Subject: Re: [lvm-devel] *** ANNOUNCEMENT *** LVM 0.9.1 beta5 available at www.sistina.com
In-Reply-To: <20010221180035.N25927@athlon.random>
	<200102211718.SAA25997@ns.caldera.de>
	<20010221221225.B21010@cadcamlab.org>
	<20010222104603.A1992@caldera.de>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  [Peter Samuelson]
> > How often do you run MAKEDEV or vgscan?

[Christoph Hellwig]
> On every bootup, _before_ doing mount -a

A mere 'vgchange -ay' works fine for *my* boot processes.  Is there a
particular reason to do 'vgscan' every time?  (I'm not arguing -- just
wondering.)

Peter
