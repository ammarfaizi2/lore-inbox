Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270273AbRHRRfw>; Sat, 18 Aug 2001 13:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270263AbRHRRfc>; Sat, 18 Aug 2001 13:35:32 -0400
Received: from sundiver.zdv.Uni-Mainz.DE ([134.93.174.136]:18670 "HELO
	duron.intern.kubla.de") by vger.kernel.org with SMTP
	id <S270261AbRHRRfb>; Sat, 18 Aug 2001 13:35:31 -0400
Date: Sat, 18 Aug 2001 19:35:39 +0200
From: Dominik Kubla <kubla@sciobyte.de>
To: Jeff Meininger <jeffm@boxybutgood.com>
Cc: Justin A <justin@bouncybouncy.net>, linux-kernel@vger.kernel.org
Subject: Re: 'detect' floppy hardware from userland?  ioctl?
Message-ID: <20010818193539.A966@duron.intern.kubla.de>
In-Reply-To: <20010817173318.A5313@bouncybouncy.net> <Pine.LNX.4.33.0108171639220.550-100000@mangonel.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0108171639220.550-100000@mangonel.localdomain>
User-Agent: Mutt/1.3.20i
X-No-Archive: yes
Restrict: no-external-archive
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2001 at 04:39:51PM -0500, Jeff Meininger wrote:
> 
> 
> > grep fd /proc/devices
> > :)
> 
> That only tells me 'fd'... I want to know 'fd0', 'fd1', etc...

The fdutils package does that: see the /usr/sbin/MAKEFLOPPIES script

Yours,
  Dominik Kubla
-- 
ScioByte GmbH, Zum Schiersteiner Grund 2, 55127 Mainz (Germany)
Phone: +49 6131 550 117  Fax: +49 6131 610 99 16

GnuPG: 717F16BB / A384 F5F1 F566 5716 5485  27EF 3B00 C007 717F 16BB
