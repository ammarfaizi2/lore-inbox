Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318015AbSFSVVY>; Wed, 19 Jun 2002 17:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318016AbSFSVVY>; Wed, 19 Jun 2002 17:21:24 -0400
Received: from ns.suse.de ([213.95.15.193]:15620 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318015AbSFSVVW>;
	Wed, 19 Jun 2002 17:21:22 -0400
Date: Wed, 19 Jun 2002 23:21:23 +0200
From: Dave Jones <davej@suse.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.23-dj2
Message-ID: <20020619232123.N29373@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Adrian Bunk <bunk@fs.tum.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20020619205136.GA18903@suse.de> <Pine.NEB.4.44.0206192311500.10290-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.NEB.4.44.0206192311500.10290-100000@mimas.fachschaften.tu-muenchen.de>; from bunk@fs.tum.de on Wed, Jun 19, 2002 at 11:16:09PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2002 at 11:16:09PM +0200, Adrian Bunk wrote:

 > Another obviously wrong bit seems to be the patch below that is still in
 > -dj2:
 > --- linux-2.5.23/drivers/isdn/hardware/avm/b1.c	Wed Jun 19 03:11:52 2002
 > +++ linux-2.5/drivers/isdn/hardware/avm/b1.c	Sat Jun  1 00:34:35 2002

Yep. ISDN bits Kai has got covered anyway (he took pickings from
2.5.23-dj1, so these can all be dropped next time round..)

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
