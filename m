Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270557AbRHNKy3>; Tue, 14 Aug 2001 06:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270558AbRHNKyT>; Tue, 14 Aug 2001 06:54:19 -0400
Received: from sunrise.pg.gda.pl ([153.19.40.230]:30355 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S270557AbRHNKyF>; Tue, 14 Aug 2001 06:54:05 -0400
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200108141053.MAA00375@sunrise.pg.gda.pl>
Subject: Re: 3c905b works with 10bt hub - not with 10/100 switch
To: aaronl@vitelus.com (Aaron Lehmann)
Date: Tue, 14 Aug 2001 12:53:53 +0200 (MET DST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010814031851.A374@vitelus.com> from "Aaron Lehmann" at Aug 14, 2001 03:18:51 AM
Reply-To: ankry@green.mif.pg.gda.pl
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Lehmann wrote:
> On Tue, Aug 14, 2001 at 02:14:45AM -0700, Aaron Lehmann wrote:
> > I've been having major problems on my network as of today.
> 
> I seem to have solved this problem.
> 
> I put in a 3c595 - same problem.
> 
> Luckily, I had the persistance to try another card. I chose to try
> Client's eth0 as Server's eth2. Well, it worked.
> 
> I hope this network setup will work on a switch for longer than the
> 3c905b did.

Did you check the board's NVRAM setting for media type ?
AFAIR changing Auto/Manual was related with this problem.

But I hit it about three years ago...

Andrzej
-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
